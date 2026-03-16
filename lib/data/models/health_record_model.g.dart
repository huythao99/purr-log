// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHealthRecordCollection on Isar {
  IsarCollection<HealthRecord> get healthRecords => this.collection();
}

const HealthRecordSchema = CollectionSchema(
  name: r'HealthRecord',
  id: -2306919757135349190,
  properties: {
    r'clinicName': PropertySchema(
      id: 0,
      name: r'clinicName',
      type: IsarType.string,
    ),
    r'cost': PropertySchema(
      id: 1,
      name: r'cost',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'documentPath': PropertySchema(
      id: 4,
      name: r'documentPath',
      type: IsarType.string,
    ),
    r'nextDueDate': PropertySchema(
      id: 5,
      name: r'nextDueDate',
      type: IsarType.dateTime,
    ),
    r'petId': PropertySchema(
      id: 6,
      name: r'petId',
      type: IsarType.long,
    ),
    r'recordDate': PropertySchema(
      id: 7,
      name: r'recordDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _HealthRecordtypeEnumValueMap,
    ),
    r'veterinarianName': PropertySchema(
      id: 10,
      name: r'veterinarianName',
      type: IsarType.string,
    )
  },
  estimateSize: _healthRecordEstimateSize,
  serialize: _healthRecordSerialize,
  deserialize: _healthRecordDeserialize,
  deserializeProp: _healthRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'petId': IndexSchema(
      id: -7951607706841349632,
      name: r'petId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'petId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _healthRecordGetId,
  getLinks: _healthRecordGetLinks,
  attach: _healthRecordAttach,
  version: '3.1.0+1',
);

int _healthRecordEstimateSize(
  HealthRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.clinicName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.documentPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.veterinarianName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _healthRecordSerialize(
  HealthRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clinicName);
  writer.writeDouble(offsets[1], object.cost);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.documentPath);
  writer.writeDateTime(offsets[5], object.nextDueDate);
  writer.writeLong(offsets[6], object.petId);
  writer.writeDateTime(offsets[7], object.recordDate);
  writer.writeString(offsets[8], object.title);
  writer.writeByte(offsets[9], object.type.index);
  writer.writeString(offsets[10], object.veterinarianName);
}

HealthRecord _healthRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HealthRecord();
  object.clinicName = reader.readStringOrNull(offsets[0]);
  object.cost = reader.readDoubleOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.documentPath = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.nextDueDate = reader.readDateTimeOrNull(offsets[5]);
  object.petId = reader.readLong(offsets[6]);
  object.recordDate = reader.readDateTime(offsets[7]);
  object.title = reader.readString(offsets[8]);
  object.type =
      _HealthRecordtypeValueEnumMap[reader.readByteOrNull(offsets[9])] ??
          HealthRecordType.vaccination;
  object.veterinarianName = reader.readStringOrNull(offsets[10]);
  return object;
}

P _healthRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (_HealthRecordtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          HealthRecordType.vaccination) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _HealthRecordtypeEnumValueMap = {
  'vaccination': 0,
  'vetVisit': 1,
  'medication': 2,
  'checkup': 3,
  'surgery': 4,
  'labTest': 5,
  'other': 6,
};
const _HealthRecordtypeValueEnumMap = {
  0: HealthRecordType.vaccination,
  1: HealthRecordType.vetVisit,
  2: HealthRecordType.medication,
  3: HealthRecordType.checkup,
  4: HealthRecordType.surgery,
  5: HealthRecordType.labTest,
  6: HealthRecordType.other,
};

Id _healthRecordGetId(HealthRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _healthRecordGetLinks(HealthRecord object) {
  return [];
}

void _healthRecordAttach(
    IsarCollection<dynamic> col, Id id, HealthRecord object) {
  object.id = id;
}

extension HealthRecordQueryWhereSort
    on QueryBuilder<HealthRecord, HealthRecord, QWhere> {
  QueryBuilder<HealthRecord, HealthRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhere> anyPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'petId'),
      );
    });
  }
}

extension HealthRecordQueryWhere
    on QueryBuilder<HealthRecord, HealthRecord, QWhereClause> {
  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> petIdEqualTo(
      int petId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'petId',
        value: [petId],
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> petIdNotEqualTo(
      int petId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'petId',
              lower: [],
              upper: [petId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'petId',
              lower: [petId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'petId',
              lower: [petId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'petId',
              lower: [],
              upper: [petId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> petIdGreaterThan(
    int petId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'petId',
        lower: [petId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> petIdLessThan(
    int petId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'petId',
        lower: [],
        upper: [petId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterWhereClause> petIdBetween(
    int lowerPetId,
    int upperPetId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'petId',
        lower: [lowerPetId],
        includeLower: includeLower,
        upper: [upperPetId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HealthRecordQueryFilter
    on QueryBuilder<HealthRecord, HealthRecord, QFilterCondition> {
  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clinicName',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clinicName',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clinicName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clinicName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clinicName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clinicName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      clinicNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clinicName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> costIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cost',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      costIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cost',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> costEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      costGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> costLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cost',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> costBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cost',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'documentPath',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'documentPath',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      documentPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentPath',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextDueDate',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextDueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      nextDueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextDueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> petIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      petIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> petIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> petIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'petId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      recordDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      recordDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      recordDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordDate',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      recordDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> typeEqualTo(
      HealthRecordType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      typeGreaterThan(
    HealthRecordType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> typeLessThan(
    HealthRecordType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition> typeBetween(
    HealthRecordType lower,
    HealthRecordType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'veterinarianName',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'veterinarianName',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'veterinarianName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'veterinarianName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'veterinarianName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'veterinarianName',
        value: '',
      ));
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterFilterCondition>
      veterinarianNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'veterinarianName',
        value: '',
      ));
    });
  }
}

extension HealthRecordQueryObject
    on QueryBuilder<HealthRecord, HealthRecord, QFilterCondition> {}

extension HealthRecordQueryLinks
    on QueryBuilder<HealthRecord, HealthRecord, QFilterCondition> {}

extension HealthRecordQuerySortBy
    on QueryBuilder<HealthRecord, HealthRecord, QSortBy> {
  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByClinicName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByClinicNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByDocumentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentPath', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByDocumentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentPath', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByRecordDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByVeterinarianName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinarianName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      sortByVeterinarianNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinarianName', Sort.desc);
    });
  }
}

extension HealthRecordQuerySortThenBy
    on QueryBuilder<HealthRecord, HealthRecord, QSortThenBy> {
  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByClinicName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByClinicNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clinicName', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByCostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cost', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByDocumentPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentPath', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByDocumentPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentPath', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByNextDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDueDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByRecordDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByVeterinarianName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinarianName', Sort.asc);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QAfterSortBy>
      thenByVeterinarianNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'veterinarianName', Sort.desc);
    });
  }
}

extension HealthRecordQueryWhereDistinct
    on QueryBuilder<HealthRecord, HealthRecord, QDistinct> {
  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByClinicName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clinicName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByCost() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cost');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByDocumentPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByNextDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDueDate');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petId');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordDate');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<HealthRecord, HealthRecord, QDistinct>
      distinctByVeterinarianName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'veterinarianName',
          caseSensitive: caseSensitive);
    });
  }
}

extension HealthRecordQueryProperty
    on QueryBuilder<HealthRecord, HealthRecord, QQueryProperty> {
  QueryBuilder<HealthRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HealthRecord, String?, QQueryOperations> clinicNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clinicName');
    });
  }

  QueryBuilder<HealthRecord, double?, QQueryOperations> costProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cost');
    });
  }

  QueryBuilder<HealthRecord, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HealthRecord, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<HealthRecord, String?, QQueryOperations> documentPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentPath');
    });
  }

  QueryBuilder<HealthRecord, DateTime?, QQueryOperations>
      nextDueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDueDate');
    });
  }

  QueryBuilder<HealthRecord, int, QQueryOperations> petIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petId');
    });
  }

  QueryBuilder<HealthRecord, DateTime, QQueryOperations> recordDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordDate');
    });
  }

  QueryBuilder<HealthRecord, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<HealthRecord, HealthRecordType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<HealthRecord, String?, QQueryOperations>
      veterinarianNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'veterinarianName');
    });
  }
}
