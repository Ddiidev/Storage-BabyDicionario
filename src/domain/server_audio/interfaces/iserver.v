module interfaces

import domain.config.interfaces as conf
import domain.server_audio.types

pub interface IServerAudio {
	conf conf.IConfig
	get_audio_profile(user_uuid string, uuid_profile string, key_word string) !types.PathAudioOnServer
}
