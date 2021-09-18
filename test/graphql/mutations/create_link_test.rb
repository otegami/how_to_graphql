require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    binding.pry
    Mutations::CreateLink.new(object: nil, field: nil, context: {}).resolve(**args)
  end

  test 'create a new link' do
    link = perform(
      description: 'description',
      url: 'http://example.com',
    )

    assert link.persisted?
    assert_equal link.description, 'description'
    assert_equal link.url, 'http://example.com'
  end
end
