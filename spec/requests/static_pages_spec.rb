require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home page" do
  	before { visit root_path }
  	it { should have_title('Mon Menu') }
  	it { should have_selector('h1', text: 'Welcome to Mon Menu') }

  	describe "header area" do
  		it { should have_selector('div.jumbotron') }
  	end
  end
end
