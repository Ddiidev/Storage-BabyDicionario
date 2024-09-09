module implementations

import domain.config.interfaces as conf
import net.http

pub struct BackendBabyDi {
pub:
	conf conf.IConfig
}

const endpoint_contain_user = '/user/contain'
const endpoint_contain_profile = '/profile/contain'

fn (bk_babydi BackendBabyDi) contain_user(uuid string) bool {
	api := bk_babydi.conf.get_backend_babydi() or { return false }

	endpoint := '${api}${implementations.endpoint_contain_user}/${uuid}'

	res := http.get(endpoint) or { return false }

	return if res.status_code == 200 {
		true
	} else {
		false
	}
}

fn (bk_babydi BackendBabyDi) contain_profile(uuid string) bool {
	api := bk_babydi.conf.get_backend_babydi() or { return false }

	endpoint := '${api}${implementations.endpoint_contain_profile}/${uuid}'

	res := http.get(endpoint) or { return false }

	return if res.status_code == 200 {
		true
	} else {
		false
	}
}
