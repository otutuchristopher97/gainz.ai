import 'package:gainz_ai_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Welcome to Gainz AI',
          description:
              'Your AI-Powered Workout Partner, for all your health needs',
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Real-Time Pose Detection',
          description:
              'Track your movements with precision and accuracy using advanced AI technology',
        );

  const PageContent.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Count Every Rep',
          description:
              'Accurately track your jumping jacks and monitor your progress in real-time',
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
