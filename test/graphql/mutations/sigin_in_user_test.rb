require 'test_helper'

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(**args)
    context = { session: { token: nil }, current_user: nil}
    Mutations::SignInUser.new(object: nil, field: nil, context: context).resolve(**args)
  end

  def create_user
    User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: '[omitted]'
    )
  end

  test 'sucess' do
    user = create_user
    result = perform(credentials: { email: user.email, password: user.password })

    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure beacause of no credentials' do
    assert_nil perform
  end

  test 'failure beacause of wrong email' do
    user = create_user
    assert_nil perform(credentials: { email: 'wrong', password: user.password })
  end

  test 'failure because of wrong password' do
    user = create_user
    assert_nil perform(credentials: { email: user.password, password: 'wrong'})
  end
end
