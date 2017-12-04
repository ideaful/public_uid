require 'test_helper'

TestConf.orm_modules.each do |orm_module|
  describe orm_module.description do
    context 'Model with default generator' do
      let(:user) { "#{orm_module}::ModelWithGeneratorDefaults".constantize.new }

      describe '#public_uid' do
        subject{ user.public_uid }

        context 'in new record' do
          it{ subject.must_be_nil }

          describe '#generate_uid' do
            before do
              user.generate_uid
            end

            it { subject.wont_be_nil }
          end
        end

        context 'after save' do

          before do
            user.save
            user.reload
          end

          it{ subject.must_be_kind_of(String) }
          it{ subject.length.must_equal(8) }
        end
      end
    end
  end
end
