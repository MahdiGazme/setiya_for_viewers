class ChangeAvatarDto {
  final String? avatarId;

  ChangeAvatarDto({
    required this.avatarId,
  });

  Map<String , dynamic> toJson() => {
    'avatarId' : avatarId,
  };
}
