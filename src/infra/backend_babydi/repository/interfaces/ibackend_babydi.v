module interfaces

pub interface IBackendBabyDi {
	contain_user(uuid string) bool
	contain_profile(uuid string) bool
	default_uuid_profile_from_user(user_uuid string) ?string
}
