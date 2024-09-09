module interfaces

pub interface IUserService {
	create_user(user_uuid string) !
}
