#!/bin/bash

# Usage 안내 및 입력 체크
if [ -z "$1" ]; then
  echo "Usage: ./generate_feature_full.sh <feature_name>"
  exit 1
fi

FEATURE=$1

# 첫 글자만 대문자 변환 (bash 내장)
FEATURE_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FEATURE:0:1})${FEATURE:1}"

echo "Input feature: $FEATURE"
echo "Class name: $FEATURE_CAP"


# 소스와 테스트 기본 경로
SRC_BASE=lib/features/$FEATURE
TEST_BASE=test/features/$FEATURE

echo "Generating feature '$FEATURE' structure with templates..."

# 1. 폴더 생성 (source)
mkdir -p $SRC_BASE/data/models
mkdir -p $SRC_BASE/data/datasources
mkdir -p $SRC_BASE/data/repositories

mkdir -p $SRC_BASE/domain/entities
mkdir -p $SRC_BASE/domain/repositories
mkdir -p $SRC_BASE/domain/usecases

mkdir -p $SRC_BASE/presentation/pages
mkdir -p $SRC_BASE/presentation/bloc
mkdir -p $SRC_BASE/presentation/widgets

# 2. 폴더 생성 (test)
mkdir -p $TEST_BASE/domain/usecases
mkdir -p $TEST_BASE/domain/repositories
mkdir -p $TEST_BASE/data/datasources
mkdir -p $TEST_BASE/data/repositories
mkdir -p $TEST_BASE/presentation/bloc

# ----------------------------
# 3. 소스 파일 생성 (기본 템플릿 포함)
# ----------------------------

# presentation/pages/${feature}_page.dart
cat > $SRC_BASE/presentation/pages/${FEATURE}_page.dart << EOF
import 'package:flutter/material.dart';

class ${FEATURE_CAP}Page extends StatelessWidget {
  const ${FEATURE_CAP}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${FEATURE_CAP} Page')),
      body: Center(child: Text('This is the ${FEATURE_CAP} page')),
    );
  }
}
EOF

# presentation/bloc/${feature}_bloc.dart
cat > $SRC_BASE/presentation/bloc/${FEATURE}_bloc.dart << EOF
// BLoC 상태관리 예시입니다.
// 필요에 따라 Provider, Riverpod 등 다른 상태관리 패턴으로 변경 가능합니다.

import 'package:flutter_bloc/flutter_bloc.dart';

class ${FEATURE_CAP}Bloc extends Bloc<${FEATURE_CAP}Event, ${FEATURE_CAP}State> {
  ${FEATURE_CAP}Bloc() : super(${FEATURE_CAP}Initial()) {
    // 이벤트 처리 구현
  }
}

// TODO: ${FEATURE_CAP}Event, ${FEATURE_CAP}State 클래스 구현 필요
EOF

# domain/entities/${feature}.dart
cat > $SRC_BASE/domain/entities/${FEATURE}.dart << EOF
class ${FEATURE_CAP} {
  final int id;
  final String name;

  ${FEATURE_CAP}({required this.id, required this.name});
}
EOF

# domain/repositories/${feature}_repository.dart
cat > $SRC_BASE/domain/repositories/${FEATURE}_repository.dart << EOF
import '../entities/${FEATURE}.dart';

abstract class ${FEATURE_CAP}Repository {
  Future<List<${FEATURE_CAP}>> getAll${FEATURE_CAP}s();
}
EOF

# domain/usecases/get_${feature}_usecase.dart
cat > $SRC_BASE/domain/usecases/get_${FEATURE}_usecase.dart << EOF
import '../entities/${FEATURE}.dart';
import '../repositories/${FEATURE}_repository.dart';

class Get${FEATURE_CAP}sUseCase {
  final ${FEATURE_CAP}Repository repository;

  Get${FEATURE_CAP}sUseCase(this.repository);

  Future<List<${FEATURE_CAP}>> execute() {
    return repository.getAll${FEATURE_CAP}s();
  }
}
EOF

# data/models/${feature}_model.dart
cat > $SRC_BASE/data/models/${FEATURE}_model.dart << EOF
import '../../domain/entities/${FEATURE}.dart';

class ${FEATURE_CAP}Model extends ${FEATURE_CAP} {
  ${FEATURE_CAP}Model({required int id, required String name}) : super(id: id, name: name);

  factory ${FEATURE_CAP}Model.fromJson(Map<String, dynamic> json) {
    return ${FEATURE_CAP}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
EOF

# data/datasources/${feature}_datasource.dart
cat > $SRC_BASE/data/datasources/${FEATURE}_datasource.dart << EOF
import 'package:dio/dio.dart';
import '../models/${FEATURE}_model.dart';

abstract class ${FEATURE_CAP}RemoteDataSource {
  Future<List<${FEATURE_CAP}Model>> fetch${FEATURE_CAP}s();
}

class ${FEATURE_CAP}RemoteDataSourceImpl implements ${FEATURE_CAP}RemoteDataSource {
  final Dio dio;

  ${FEATURE_CAP}RemoteDataSourceImpl(this.dio);

  @override
  Future<List<${FEATURE_CAP}Model>> fetch${FEATURE_CAP}s() async {
    final response = await dio.get('/${FEATURE}s');
    final data = response.data as List;
    return data.map((json) => ${FEATURE_CAP}Model.fromJson(json)).toList();
  }
}
EOF

# data/repositories/${feature}_repository_impl.dart
cat > $SRC_BASE/data/repositories/${FEATURE}_repository_impl.dart << EOF
import '../../domain/entities/${FEATURE}.dart';
import '../../domain/repositories/${FEATURE}_repository.dart';
import '../datasources/${FEATURE}_datasource.dart';

class ${FEATURE_CAP}RepositoryImpl implements ${FEATURE_CAP}Repository {
  final ${FEATURE_CAP}RemoteDataSource remoteDataSource;

  ${FEATURE_CAP}RepositoryImpl(this.remoteDataSource);

  @override
  Future<List<${FEATURE_CAP}>> getAll${FEATURE_CAP}s() {
    return remoteDataSource.fetch${FEATURE_CAP}s();
  }
}
EOF

# ----------------------------
# 4. 테스트 파일 생성 (기본 템플릿 포함)
# ----------------------------

# domain/usecases 테스트
cat > $TEST_BASE/domain/usecases/get_${FEATURE}_usecase_test.dart << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:${FEATURE}/domain/usecases/get_${FEATURE}_usecase.dart';
import 'package:${FEATURE}/domain/repositories/${FEATURE}_repository.dart';

class Mock${FEATURE_CAP}Repository extends Mock implements ${FEATURE_CAP}Repository {}

void main() {
  late Get${FEATURE_CAP}sUseCase usecase;
  late Mock${FEATURE_CAP}Repository mockRepository;

  setUp(() {
    mockRepository = Mock${FEATURE_CAP}Repository();
    usecase = Get${FEATURE_CAP}sUseCase(mockRepository);
  });

  test('should get list of ${FEATURE}s from repository', () async {
    // TODO: 테스트 구현
  });
}
EOF

# data/datasources 테스트
cat > $TEST_BASE/data/datasources/${FEATURE}_datasource_test.dart << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:${FEATURE}/data/datasources/${FEATURE}_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ${FEATURE_CAP}RemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ${FEATURE_CAP}RemoteDataSourceImpl(mockDio);
  });

  test('should fetch list of ${FEATURE}s from remote API', () async {
    // TODO: 테스트 구현
  });
}
EOF

# data/repositories 테스트
cat > $TEST_BASE/data/repositories/${FEATURE}_repository_impl_test.dart << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:${FEATURE}/data/repositories/${FEATURE}_repository_impl.dart';
import 'package:${FEATURE}/data/datasources/${FEATURE}_datasource.dart';

class MockRemoteDataSource extends Mock implements ${FEATURE_CAP}RemoteDataSource {}

void main() {
  late ${FEATURE_CAP}RepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = ${FEATURE_CAP}RepositoryImpl(mockRemoteDataSource);
  });

  test('should get list of ${FEATURE}s from remote data source', () async {
    // TODO: 테스트 구현
  });
}
EOF

# presentation/bloc 테스트
cat > $TEST_BASE/presentation/bloc/${FEATURE}_bloc_test.dart << EOF
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:${FEATURE}/presentation/bloc/${FEATURE}_bloc.dart';

void main() {
  group('${FEATURE_CAP}Bloc', () {
    // TODO: bloc 테스트 구현
  });
}
EOF

echo "Feature '$FEATURE' source and test templates created successfully!"
