require "test_helper"

class ProjectTest
  class Validations < ActiveSupport::TestCase
    test "not valid by defailt" do
      refute Project.new.valid?
    end

    test "validates presence of title" do
      project = Project.new
      project.valid?

      assert project.errors.of_kind?(:title, :blank)
    end

    test "validates presence of status" do
      project = Project.new
      project.valid?

      assert project.errors.of_kind?(:status, :blank)
    end
  end
end
