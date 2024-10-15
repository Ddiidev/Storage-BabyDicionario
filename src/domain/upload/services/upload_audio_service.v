module services

import os
import rand

fn (serv &UploadService) upload_audio(user_uuid string, uuid_profile string, key_word string, data string) ! {
	work_dir := serv.conf.get_work_dir() or { return error('Falha interna.') }
	path_user := os.join_path(work_dir, user_uuid)
	path_user_profile := os.join_path(path_user, uuid_profile)
	path_audio_dest := os.join_path(path_user_profile, '${key_word}.mp3')

	if !os.exists(path_user) {
		return error('Usuário não encontrado.')
	}

	if !os.exists(path_user_profile) {
		os.mkdir(path_user_profile) or { return error('Erro ao criar pasta do perfil.') }
	}

	os.write_file(path_audio_dest, data) or { return error('Erro ao salvar áudio') }
}

struct GenerateNameFileParam {
	path string
mut:
	recursive_count int
}

fn generate_name_file(param GenerateNameFileParam) !string {
	mut recursive_count := param.recursive_count
	recursive_count++
	if recursive_count > 15 {
		return error('Erro ao gerar nome do arquivo.')
	}

	name_file := rand.uuid_v4()
	if os.exists(os.join_path(param.path, name_file)) {
		return generate_name_file(
			path:            param.path
			recursive_count: recursive_count
		)
	}

	return name_file
}
