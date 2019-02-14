require_relative 'reverse_odds'

describe "reverse_odds" do
	context "when input is invalid" do
		context "when input is not text" do
			it "should raise a TypeError" do
				expect{ reverse_odds(12) }.to raise_error(TypeError)
			end	
		end	
	end

	context "when input is valid" do
		it "should return the string with the odd indices reversed" do
			expect(reverse_odds("hello world")).to eq "hlloo wlred"
		end

		it "should not create a new string" do 
			text = "hello"
			
			expect(reverse_odds(text).object_id).to eq text.object_id
		end
	end
end
