// ignore_for_file: constant_identifier_names

import 'package:logger/logger.dart';

export './network/params.dart';
export './network/repository.dart';

export './support_files/theme.dart';
// export './support_files/assets.gen.dart';

export './app/routes/app_pages.dart';

export './app/widgets/dialog.dart';

export './common/widgets/app_bar.dart';
export './common/widgets/data_scaffold.dart';
export './common/widgets/empty_data_view.dart';
export './common/widgets/network_image_view.dart';
export './common/widgets/toast.dart';
export './common/widgets/custom_image.dart';
export './common/widgets/primary_button.dart';
export './common/extensions/size_box_entension.dart';
export './common/widgets/circle_leading.dart';

export './app/widgets/chat_btn.dart';

export './common/refresh/refresh.dart';
export './common/util.dart';

export './generated/assets.dart';
export './config.dart';

export './services/app.dart';
export './services/user.dart';
export './services/config.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

final logger = Logger(printer: PrettyPrinter(lineLength: 500));

/// deep link
const String kUrlScheme = 'chanyetong://handi';
