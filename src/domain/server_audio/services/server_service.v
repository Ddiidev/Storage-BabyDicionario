module services

import domain.config.interfaces as conf
import domain.server_audio.types
import os

pub struct ServerAudioService {
pub:
	conf conf.IConfig
}

fn (serv &ServerAudioService) get_audio_profile(user_uuid string, uuid_profile string, key_word string) !types.PathAudioOnServer {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }

	if !os.exists(os.join_path(work_dir, user_uuid)) {
		return error('Usuário não encontrado.')
	}

	return os.join_path(work_dir, user_uuid, uuid_profile, '${key_word}.mp3')
}
