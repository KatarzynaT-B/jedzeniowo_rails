module ProfilesHelper
  def profile_gender_as_string(profile)
    profile.gender == 1 ? 'kobieta' : 'mężczyzna'
  end
end
