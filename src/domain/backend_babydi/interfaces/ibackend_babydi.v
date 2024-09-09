module interfaces

pub interface IBackendBabyDi {
	contain_user(uuid string) bool
	contain_profile(uuid string) bool
}
