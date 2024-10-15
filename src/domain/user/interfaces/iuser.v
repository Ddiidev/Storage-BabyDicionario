module interfaces

pub interface IUserService {
	create(user_uuid string) !
	delete(user_uuid string, profile_uuid string) !
}
