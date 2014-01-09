require 'spec_helper'

describe "customers/index" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :name => "Name",
        :id => 1,
        :acc_name => "Acc Name"
      ),
      stub_model(Customer,
        :name => "Name",
        :id => 1,
        :acc_name => "Acc Name"
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Acc Name".to_s, :count => 2
  end
end
