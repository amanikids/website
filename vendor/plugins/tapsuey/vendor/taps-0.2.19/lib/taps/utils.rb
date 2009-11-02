require 'zlib'
require 'stringio'
require 'time'
require 'tempfile'

module Taps
module Utils
	extend self

	def windows?
		RUBY_PLATFORM =~ /mswin32/
	end

	def bin(cmd)
		cmd = "#{cmd}.cmd" if windows?
		cmd
	end

	def checksum(data)
		Zlib.crc32(data)
	end

	def valid_data?(data, crc32)
		Zlib.crc32(data) == crc32.to_i
	end

	def gzip(data)
		io = StringIO.new
		gz = Zlib::GzipWriter.new(io)
		gz.write data
		gz.close
		io.string
	end

	def gunzip(gzip_data)
		io = StringIO.new(gzip_data)
		gz = Zlib::GzipReader.new(io)
		data = gz.read
		gz.close
		data
	end

	def format_data(data, string_columns)
		return {} if data.size == 0
		header = data[0].keys
		only_data = data.collect do |row|
			row = blobs_to_string(row, string_columns)
			header.collect { |h| row[h] }
		end
		{ :header => header, :data => only_data }
	end

	# mysql text and blobs fields are handled the same way internally
	# this is not true for other databases so we must check if the field is
	# actually text and manually convert it back to a string
	def incorrect_blobs(db, table)
		return [] unless db.class.to_s == "Sequel::MySQL::Database"

		columns = []
		db.schema(table).each do |data|
			column, cdata = data
			columns << column if cdata[:db_type] =~ /text/
		end
		columns
	end

	def blobs_to_string(row, columns)
		return row if columns.size == 0
		columns.each do |c|
			row[c] = row[c].to_s if row[c].kind_of?(Sequel::SQL::Blob)
		end
		row
	end

	def calculate_chunksize(old_chunksize)
		chunksize = old_chunksize

		retries = 0
		begin
			t1 = Time.now
			yield chunksize
		rescue Errno::EPIPE
			retries += 1
			raise if retries > 1
			# we got disconnected, the chunksize could be too large
			# so we're resetting to a very small value
			chunksize = 100
			retry
		end

		t2 = Time.now

		diff = t2 - t1
		new_chunksize = if diff > 3.0
			(chunksize / 3).ceil
		elsif diff > 1.1
			chunksize - 100
		elsif diff < 0.8
			chunksize * 2
		else
			chunksize + 100
		end
		new_chunksize = 100 if new_chunksize < 100
		new_chunksize
	end

	def load_schema(database_url, schema_data)
		Tempfile.open('taps') do |tmp|
			File.open(tmp.path, 'w') { |f| f.write(schema_data) }
			schema_bin(:load, database_url, tmp.path)
		end
	end

	def load_indexes(database_url, index_data)
		Tempfile.open('taps') do |tmp|
			File.open(tmp.path, 'w') { |f| f.write(index_data) }
			schema_bin(:load_indexes, database_url, tmp.path)
		end
	end

	def schema_bin(*args)
		`#{File.dirname(__FILE__)}/../../bin/#{bin('schema')} #{args.join(' ')}`
	end

	def primary_key(db, table)
		if db.respond_to?(:primary_key)
			db.primary_key(table)
		else
			db.schema(table).select { |c| c[1][:primary_key] }.map { |c| c.first }.shift
		end
	end

	def order_by(db, table)
		pkey = primary_key(db, table)
		if pkey
			[pkey.to_sym]
		else
			db[table].columns
		end
	end
end
end
