require 'spec_helper'

if defined?(Rails)
  describe :my_migration do
    it "should run migration template" do
      # bug, raising NameError: undefined local variable or method `interceptor'
      proc { subject.should generate_file(:migration_template, "1", "2") }.should_not raise_error
    end
  end
end
