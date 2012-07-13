require 'spec_helper'

describe :test_rails3 do
  within_source_root do
    FileUtils.touch "Gemfile"
  end
  
  it "should modify Gemfile" do
    out = ""
    subject.should generate_file {
      File.read("Gemfile").strip.should_not be_blank
      out.concat File.read("Gemfile")
    }
    out.strip.should == 'source "http://gems.github.com/"'
  end
  
  context "with no options or arguments" do
    it "should generate a file called default_file" do
      subject.should     generate_file("default_file")
      subject.should_not generate_file("some_other_file")
      
      subject.should     call_action(:create_file)
      subject.should     call_action(:create_file, "default_file")
      subject.should_not call_action(:create_file, "some_other_file")
      
      subject.should     create_file
      subject.should     create_file('default_file')
      subject.should_not create_file("some_other_file")
    end
    
    it "should generate a file with specific content" do
      subject.should generate_file("default_file") { |content| content.should == "content!" }
      subject.should generate_file("default_file") { |content| content.should_not == "!content" }
      subject.should_not generate_file("some_other_file")
    end
    
    it "should generate a template called 'default_template'" do
      subject.should generate_file(:template)
      subject.should generate_file(:template, 'file', 'file_template')
    end
    
    it "should output 'create    file'" do
      subject.should output(/create\s+default_file/)
    end
    
    it "shoud generate a directory called 'a_directory'" do
      subject.should     generate_file(:empty_directory)
      subject.should     generate_file(:empty_directory, "a_directory")
      subject.should     generate_file("a_directory")
      subject.should_not generate_file(:empty_directory, 'another_directory')
      subject.should     empty_directory("a_directory")
      subject.should_not empty_directory("another_directory")
    end
    
    # if the other tests pass then it seems to be working properly, but let's make sure
    # Rails-specific actions are also working. If they are, it's safe to say custom extensions
    # will work fine too.
    it 'should add_source "http://gems.github.com/"' do
      if defined?(Rails)
        subject.should add_source("http://gems.github.com/")
      end
    end
  end
  
  with_args '--help' do
    it "should output usage banner with string" do
      subject.should output(" test_rails3 [ARGUMENT1]")
    end
    
    it "should output usage banner with regexp" do
      subject.should output(/ test_rails3 /)
    end
  end
  
  context "with arguments without block" do
    with_args :test_arg
    
    it "should generate file 'test_arg'" do
      subject.should generate_file('test_arg')
    end
  end

  with_args :test_arg do
    it "should generate file 'test_arg'" do
      subject.should generate_file('test_arg')
    end
    
    it "should not generate template_name" do
      # because that option hasn't been given in this context.
      subject.should_not generate_file('template_name')
    end
    
    with_generator_options :behavior => :revoke do
      it "should delete file 'test_arg'" do
        subject.should generate_file {
          File.should_not exist("test_arg")
        }
      end
      
      # demonstrate use of the `delete` matcher, which is equivalent to
      # above:
      it "should destroy file 'test_arg'" do
        subject.should delete_file("test_arg")
      end
    end
    
    # ...and a test of nested args
    with_args "template_name" do
      it "should generate file 'test_arg'" do
        subject.should generate_file('test_arg')
      end

      it "should generate file 'template_name'" do
        subject.should generate_file("template_name")
      end
    end
  end
end
