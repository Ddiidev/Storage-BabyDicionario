module interfaces

pub interface IUserService {
	create(user_uuid string) !
}
