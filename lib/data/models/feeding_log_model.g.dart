// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_log_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFeedingLogCollection on Isar {
  IsarCollection<FeedingLog> get feedingLogs => this.collection();
}

const FeedingLogSchema = CollectionSchema(
  name: r'FeedingLog',
  id: -8664489784310472491,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'feedingTime': PropertySchema(
      id: 1,
      name: r'feedingTime',
      type: IsarType.dateTime,
    ),
    r'foodName': PropertySchema(
      id: 2,
      name: r'foodName',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 3,
      name: r'notes',
      type: IsarType.string,
    ),
    r'petFoodId': PropertySchema(
      id: 4,
      name: r'petFoodId',
      type: IsarType.long,
    ),
    r'petId': PropertySchema(
      id: 5,
      name: r'petId',
      type: IsarType.long,
    ),
    r'portionGrams': PropertySchema(
      id: 6,
      name: r'portionGrams',
      type: IsarType.double,
    ),
    r'totalKcal': PropertySchema(
      id: 7,
      name: r'totalKcal',
      type: IsarType.double,
    )
  },
  estimateSize: _feedingLogEstimateSize,
  serialize: _feedingLogSerialize,
  deserialize: _feedingLogDeserialize,
  deserializeProp: _feedingLogDeserializeProp,
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
    ),
    r'feedingTime': IndexSchema(
      id: 5454725405373755232,
      name: r'feedingTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'feedingTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _feedingLogGetId,
  getLinks: _feedingLogGetLinks,
  attach: _feedingLogAttach,
  version: '3.1.0+1',
);

int _feedingLogEstimateSize(
  FeedingLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.foodName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _feedingLogSerialize(
  FeedingLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.feedingTime);
  writer.writeString(offsets[2], object.foodName);
  writer.writeString(offsets[3], object.notes);
  writer.writeLong(offsets[4], object.petFoodId);
  writer.writeLong(offsets[5], object.petId);
  writer.writeDouble(offsets[6], object.portionGrams);
  writer.writeDouble(offsets[7], object.totalKcal);
}

FeedingLog _feedingLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeedingLog();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.feedingTime = reader.readDateTime(offsets[1]);
  object.foodName = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[3]);
  object.petFoodId = reader.readLongOrNull(offsets[4]);
  object.petId = reader.readLong(offsets[5]);
  object.portionGrams = reader.readDouble(offsets[6]);
  object.totalKcal = reader.readDouble(offsets[7]);
  return object;
}

P _feedingLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _feedingLogGetId(FeedingLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _feedingLogGetLinks(FeedingLog object) {
  return [];
}

void _feedingLogAttach(IsarCollection<dynamic> col, Id id, FeedingLog object) {
  object.id = id;
}

extension FeedingLogQueryWhereSort
    on QueryBuilder<FeedingLog, FeedingLog, QWhere> {
  QueryBuilder<FeedingLog, FeedingLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhere> anyPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'petId'),
      );
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhere> anyFeedingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'feedingTime'),
      );
    });
  }
}

extension FeedingLogQueryWhere
    on QueryBuilder<FeedingLog, FeedingLog, QWhereClause> {
  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> idBetween(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> petIdEqualTo(
      int petId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'petId',
        value: [petId],
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> petIdNotEqualTo(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> petIdGreaterThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> petIdLessThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> petIdBetween(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> feedingTimeEqualTo(
      DateTime feedingTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'feedingTime',
        value: [feedingTime],
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> feedingTimeNotEqualTo(
      DateTime feedingTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'feedingTime',
              lower: [],
              upper: [feedingTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'feedingTime',
              lower: [feedingTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'feedingTime',
              lower: [feedingTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'feedingTime',
              lower: [],
              upper: [feedingTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause>
      feedingTimeGreaterThan(
    DateTime feedingTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'feedingTime',
        lower: [feedingTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> feedingTimeLessThan(
    DateTime feedingTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'feedingTime',
        lower: [],
        upper: [feedingTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterWhereClause> feedingTimeBetween(
    DateTime lowerFeedingTime,
    DateTime upperFeedingTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'feedingTime',
        lower: [lowerFeedingTime],
        includeLower: includeLower,
        upper: [upperFeedingTime],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FeedingLogQueryFilter
    on QueryBuilder<FeedingLog, FeedingLog, QFilterCondition> {
  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      feedingTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      feedingTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      feedingTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      feedingTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedingTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foodName',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      foodNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foodName',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      foodNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      foodNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> foodNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      foodNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      foodNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodName',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      petFoodIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'petFoodId',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      petFoodIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'petFoodId',
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petFoodIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petFoodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      petFoodIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'petFoodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petFoodIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'petFoodId',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petFoodIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'petFoodId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petIdGreaterThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petIdLessThan(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> petIdBetween(
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

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      portionGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      portionGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'portionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      portionGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'portionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      portionGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'portionGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> totalKcalEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalKcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition>
      totalKcalGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalKcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> totalKcalLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalKcal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterFilterCondition> totalKcalBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalKcal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension FeedingLogQueryObject
    on QueryBuilder<FeedingLog, FeedingLog, QFilterCondition> {}

extension FeedingLogQueryLinks
    on QueryBuilder<FeedingLog, FeedingLog, QFilterCondition> {}

extension FeedingLogQuerySortBy
    on QueryBuilder<FeedingLog, FeedingLog, QSortBy> {
  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByFeedingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedingTime', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByFeedingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedingTime', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByFoodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByFoodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPetFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petFoodId', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPetFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petFoodId', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portionGrams', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByPortionGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portionGrams', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByTotalKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalKcal', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> sortByTotalKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalKcal', Sort.desc);
    });
  }
}

extension FeedingLogQuerySortThenBy
    on QueryBuilder<FeedingLog, FeedingLog, QSortThenBy> {
  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByFeedingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedingTime', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByFeedingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedingTime', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByFoodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByFoodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodName', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPetFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petFoodId', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPetFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petFoodId', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portionGrams', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByPortionGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portionGrams', Sort.desc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByTotalKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalKcal', Sort.asc);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QAfterSortBy> thenByTotalKcalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalKcal', Sort.desc);
    });
  }
}

extension FeedingLogQueryWhereDistinct
    on QueryBuilder<FeedingLog, FeedingLog, QDistinct> {
  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByFeedingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'feedingTime');
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByFoodName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByPetFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petFoodId');
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petId');
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'portionGrams');
    });
  }

  QueryBuilder<FeedingLog, FeedingLog, QDistinct> distinctByTotalKcal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalKcal');
    });
  }
}

extension FeedingLogQueryProperty
    on QueryBuilder<FeedingLog, FeedingLog, QQueryProperty> {
  QueryBuilder<FeedingLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FeedingLog, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FeedingLog, DateTime, QQueryOperations> feedingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedingTime');
    });
  }

  QueryBuilder<FeedingLog, String?, QQueryOperations> foodNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodName');
    });
  }

  QueryBuilder<FeedingLog, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<FeedingLog, int?, QQueryOperations> petFoodIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petFoodId');
    });
  }

  QueryBuilder<FeedingLog, int, QQueryOperations> petIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petId');
    });
  }

  QueryBuilder<FeedingLog, double, QQueryOperations> portionGramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'portionGrams');
    });
  }

  QueryBuilder<FeedingLog, double, QQueryOperations> totalKcalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalKcal');
    });
  }
}
