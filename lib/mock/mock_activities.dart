import '../models/activity_model.dart';

final List<Activity> mockActivities = [
  Activity(
    id: '1',
    title: 'Workshop: Ứng dụng AI trong học tập và lập trình',
    description: 'Khám phá cách ứng dụng trí tuệ nhân tạo vào học tập, nghiên cứu và phát triển phần mềm.',
    content: '''
      <h2>Giới thiệu chương trình</h2>
      <p>Workshop giúp sinh viên tiếp cận các công cụ AI hiện đại và ứng dụng vào học tập, lập trình.</p>
      <h3>Nội dung chương trình</h3>
      <ul>
        <li>Giới thiệu về trí tuệ nhân tạo.</li>
        <li>Ứng dụng AI trong lập trình.</li>
        <li>Hướng dẫn sử dụng các công cụ AI.</li>
        <li>Giao lưu và giải đáp thắc mắc.</li>
      </ul>
      <p><strong>Đối tượng:</strong> Sinh viên Khoa Công nghệ Thông tin.</p>
    ''',
    categoryId: 'category_1',
    categoryName: 'Học thuật',
    location: 'Hội trường A - Trường Đại học Công Thương TP.HCM',
    imageUrl: 'assets/imgs/hd1.jpg',
    status: 'ongoing',
    startTime: DateTime(2026, 11, 12, 8),
    endTime: DateTime(2026, 11, 12, 11, 30),
    registrationDeadline: DateTime(2026, 11, 10, 23, 59),
    maxParticipants: 150,
    registeredCount: 87,
    registered: false,
  ),
  Activity(
    id: '2',
    title: 'Cuộc thi lập trình IT Challenge 2026',
    description: 'Sân chơi dành cho sinh viên yêu thích lập trình, thuật toán và giải quyết vấn đề.',
    content: '''
      <h2>IT Challenge 2026</h2>
      <p>Cuộc thi tạo cơ hội để sinh viên thể hiện kỹ năng lập trình và tư duy thuật toán.</p>
      <h3>Thể lệ</h3>
      <ul>
        <li>Tham gia theo cá nhân.</li>
        <li>Giải các bài toán lập trình trong thời gian quy định.</li>
        <li>Đánh giá dựa trên số bài giải đúng và thời gian hoàn thành.</li>
      </ul>
    ''',
    categoryId: 'category_2',
    categoryName: 'Cuộc thi',
    location: 'Phòng máy B.204',
    imageUrl: 'assets/imgs/hd2.jpg',
    status: 'ongoing',
    startTime: DateTime(2026, 11, 20, 8),
    endTime: DateTime(2026, 11, 20, 17),
    registrationDeadline: DateTime(2026, 11, 18, 23, 59),
    maxParticipants: 100,
    registeredCount: 64,
    registered: true,
  ),
  Activity(
    id: '3',
    title: 'Ngày hội tình nguyện vì cộng đồng',
    description: 'Hoạt động tình nguyện nhằm lan tỏa tinh thần trách nhiệm và gắn kết sinh viên.',
    content: '''
      <h2>Ngày hội tình nguyện</h2>
      <p>Chương trình dành cho sinh viên mong muốn đóng góp cho cộng đồng.</p>
      <h3>Các hoạt động chính</h3>
      <ul>
        <li>Vệ sinh môi trường.</li>
        <li>Hỗ trợ các hoạt động cộng đồng.</li>
        <li>Giao lưu cùng các tình nguyện viên.</li>
      </ul>
    ''',
    categoryId: 'category_3',
    categoryName: 'Đoàn - Hội',
    location: 'Sân trường',
    imageUrl: 'assets/imgs/hd3.jpg',
    status: 'ongoing',
    startTime: DateTime(2026, 11, 25, 7),
    endTime: DateTime(2026, 11, 25, 16),
    registrationDeadline: DateTime(2026, 11, 23, 23, 59),
    maxParticipants: 200,
    registeredCount: 125,
  ),
  Activity(
    id: '4',
    title: 'Chuyên đề định hướng nghề nghiệp ngành CNTT',
    description: 'Chia sẻ kinh nghiệm nghề nghiệp, kỹ năng phỏng vấn và định hướng phát triển bản thân.',
    content: '''
      <h2>Định hướng nghề nghiệp</h2>
      <p>Chương trình mang đến góc nhìn thực tế về thị trường lao động ngành CNTT.</p>
      <h3>Nội dung</h3>
      <ul>
        <li>Xu hướng tuyển dụng ngành CNTT.</li>
        <li>Kỹ năng viết CV và phỏng vấn.</li>
        <li>Chia sẻ kinh nghiệm từ doanh nghiệp.</li>
      </ul>
    ''',
    categoryId: 'category_1',
    categoryName: 'Học thuật',
    location: 'Hội trường C',
    imageUrl: 'assets/imgs/hd4.jpg',
    status: 'completed',
    startTime: DateTime(2026, 9, 20, 13, 30),
    endTime: DateTime(2026, 9, 20, 16, 30),
    registrationDeadline: DateTime(2026, 9, 18),
    maxParticipants: 120,
    registeredCount: 120,
  ),
];
