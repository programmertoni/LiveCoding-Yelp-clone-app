Fabricator(:friend) do
  pending      { false }
  user_blocked { false }
  a_friend     { true }
  id_of_friend { Fabricate(:user).id }
end
