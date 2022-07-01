require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Xcconfigempty do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ xcconfigEmpty }).should.be.instance_of Command::Xcconfigempty
      end
    end
  end
end

