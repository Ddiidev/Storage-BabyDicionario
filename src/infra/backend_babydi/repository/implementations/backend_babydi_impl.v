module implementations

import json
import net.http
import infra.backend_babydi.contracts.contract_api
import domain.config.interfaces as conf

pub struct BackendBabyDi {
pub:
	conf conf.IConfig
}

const endpoint_contain_user = '/user/contain'
const endpoint_contain_profile = '/profile/contain'
const endpoint_default_uuid_profile_from_user = '/profile/default-from-user'

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

fn (bk_babydi BackendBabyDi) default_uuid_profile_from_user(user_uuid string) ?string {
	api := bk_babydi.conf.get_backend_babydi() or { return none }

	endpoint := '${api}${implementations.endpoint_default_uuid_profile_from_user}/${user_uuid}'
	res := http.get(endpoint) or { return none }

	if res.status_code == 200 {
		result := json.decode(contract_api.ContractApi[string], res.body) or { return none }
		
		return result.content
	}

	return none
}