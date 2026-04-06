class Recording {
  final String filePath;
  final DateTime timestamp;

  const Recording({
    required this.filePath,
    required this.timestamp,
  });

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
    filePath: json['filePath'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );

  Map<String, dynamic> toJson() => {
    'filePath': filePath,
    'timestamp': timestamp.toIso8601String(),
  };

  Recording copyWith({String? filePath, DateTime? timestamp}) => Recording(
    filePath: filePath ?? this.filePath,
    timestamp: timestamp ?? this.timestamp,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recording &&
          runtimeType == other.runtimeType &&
          filePath == other.filePath &&
          timestamp == other.timestamp;

  @override
  int get hashCode => Object.hash(filePath, timestamp);

  @override
  String toString() => 'Recording(filePath: $filePath, timestamp: $timestamp)';
}