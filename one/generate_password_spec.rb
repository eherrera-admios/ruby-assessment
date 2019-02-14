require_relative 'generate_password'

describe "generate_password" do
	it "should be at least 6 characters long" do
		expect(generate_password.length).to be >= 6
	end

	it "should contain at least one uppercase letter" do
                password = generate_password()
		expect(UPPERCASE.any? { |c| password.include? c  }).to be true
	end

	it "should contain at least one lowercase letter" do
		password = generate_password()
		expect(LOWERCASE.any? { |c| password.include? c  }).to be true
	end

	it "should contain at least one number" do
		password = generate_password()
		expect(NUMBER.any? { |c| password.include? c  }).to be true
	end
end
