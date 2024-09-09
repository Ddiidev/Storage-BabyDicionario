module services

import domain.backend_babydi.interfaces as backend

pub struct ProfileService {
pub:
	api backend.IBackendBabyDi
}

fn (p ProfileService) contain(uuid string) bool {
	return p.api.contain_profile(uuid)
}
