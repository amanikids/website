require File.dirname(__FILE__) + '/base'
require File.dirname(__FILE__) + '/../lib/taps/utils'

describe Taps::Utils do
	it "gunzips a string" do
		@hello_world = "\037\213\b\000R\261\207I\000\003\313H\315\311\311W(\317/\312I\001\000\205\021J\r\v\000\000\000"
		Taps::Utils.gunzip(@hello_world).should == "hello world"
	end

	it "gzips and gunzips a string and returns the same string" do
		Taps::Utils.gunzip(Taps::Utils.gzip("hello world")).should == "hello world"
	end

	it "generates a checksum using crc32" do
		Taps::Utils.checksum("hello world").should == Zlib.crc32("hello world")
	end

	it "formats a data hash into one hash that contains an array of headers and an array of array of data" do
		first_row = { :x => 1, :y => 1 }
		first_row.stubs(:keys).returns([:x, :y])
		Taps::Utils.format_data([ first_row, { :x => 2, :y => 2 } ], []).should == { :header => [ :x, :y ], :data => [ [1, 1], [2, 2] ] }
	end

	it "scales chunksize down slowly when the time delta of the block is just over a second" do
		Time.stubs(:now).returns(10.0).returns(11.5)
		Taps::Utils.calculate_chunksize(1000) { }.should == 900
	end

	it "scales chunksize down fast when the time delta of the block is over 3 seconds" do
		Time.stubs(:now).returns(10.0).returns(15.0)
		Taps::Utils.calculate_chunksize(3000) { }.should == 1000
	end

	it "scales up chunksize fast when the time delta of the block is under 0.8 seconds" do
		Time.stubs(:now).returns(10.0).returns(10.7)
		Taps::Utils.calculate_chunksize(1000) { }.should == 2000
	end

	it "scales up chunksize slow when the time delta of the block is between 0.8 and 1.1 seconds" do
		Time.stubs(:now).returns(10.0).returns(10.8)
		Taps::Utils.calculate_chunksize(1000) { }.should == 1100

		Time.stubs(:now).returns(10.0).returns(11.1)
		Taps::Utils.calculate_chunksize(1000) { }.should == 1100
	end

	it "will reset the chunksize to a small value if we got a broken pipe exception" do
		Taps::Utils.calculate_chunksize(1000) { |c| raise Errno::EPIPE if c == 1000; c.should == 100 }.should == 200
	end

	it "returns a list of columns that are text fields if the database is mysql" do
		@db = mock("db")
		@db.class.stubs(:to_s).returns("Sequel::MySQL::Database")
		@db.stubs(:schema).with(:mytable).returns([
			[:id, { :db_type => "int" }],
			[:mytext, { :db_type => "text" }]
		])
		Taps::Utils.incorrect_blobs(@db, :mytable).should == [:mytext]
	end
end

