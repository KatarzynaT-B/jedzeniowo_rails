require 'spec_helper'

describe ApplicationHelper do
  describe "full_title" do
    it "should include the page title" do
      expect(full_title('foo')).to match(/foo/)
    end

    it "should include the base title" do
      expect(full_title('foo')).to match(/^Jedzeniowo/)
    end

    it "should not include a bar while given empty string" do
      expect(full_title('')).not_to match(/\|/)
    end
  end
end