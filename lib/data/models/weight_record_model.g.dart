// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeightRecordCollection on Isar {
  IsarCollection<WeightRecord> get weightRecords => this.collection();
}

const WeightRecordSchema = CollectionSchema(
  name: r'WeightRecord',
  id: 2436710731000945560,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'notes': PropertySchema(
      id: 1,
      name: r'notes',
      type: IsarType.string,
    ),
    r'petId': PropertySchema(
      id: 2,
      name: r'petId',
      type: IsarType.long,
    ),
    r'recordDate': PropertySchema(
      id: 3,
      name: r'recordDate',
      type: IsarType.dateTime,
    ),
    r'weight': PropertySchema(
      id: 4,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _weightRecordEstimateSize,
  serialize: _weightRecordSerialize,
  deserialize: _weightRecordDeserialize,
  deserializeProp: _weightRecordDeserializeProp,
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
    r'recordDate': IndexSchema(
      id: 4518657703709673532,
      name: r'recordDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'recordDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _weightRecordGetId,
  getLinks: _weightRecordGetLinks,
  attach: _weightRecordAttach,
  version: '3.1.0+1',
);

int _weightRecordEstimateSize(
  WeightRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _weightRecordSerialize(
  WeightRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.notes);
  writer.writeLong(offsets[2], object.petId);
  writer.writeDateTime(offsets[3], object.recordDate);
  writer.writeDouble(offsets[4], object.weight);
}

WeightRecord _weightRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeightRecord();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[1]);
  object.petId = reader.readLong(offsets[2]);
  object.recordDate = reader.readDateTime(offsets[3]);
  object.weight = reader.readDouble(offsets[4]);
  return object;
}

P _weightRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weightRecordGetId(WeightRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weightRecordGetLinks(WeightRecord object) {
  return [];
}

void _weightRecordAttach(
    IsarCollection<dynamic> col, Id id, WeightRecord object) {
  object.id = id;
}

extension WeightRecordQueryWhereSort
    on QueryBuilder<WeightRecord, WeightRecord, QWhere> {
  QueryBuilder<WeightRecord, WeightRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhere> anyPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'petId'),
      );
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhere> anyRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'recordDate'),
      );
    });
  }
}

extension WeightRecordQueryWhere
    on QueryBuilder<WeightRecord, WeightRecord, QWhereClause> {
  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> petIdEqualTo(
      int petId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'petId',
        value: [petId],
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> petIdNotEqualTo(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> petIdGreaterThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> petIdLessThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> petIdBetween(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> recordDateEqualTo(
      DateTime recordDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'recordDate',
        value: [recordDate],
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause>
      recordDateNotEqualTo(DateTime recordDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordDate',
              lower: [],
              upper: [recordDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordDate',
              lower: [recordDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordDate',
              lower: [recordDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'recordDate',
              lower: [],
              upper: [recordDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause>
      recordDateGreaterThan(
    DateTime recordDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordDate',
        lower: [recordDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause>
      recordDateLessThan(
    DateTime recordDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordDate',
        lower: [],
        upper: [recordDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterWhereClause> recordDateBetween(
    DateTime lowerRecordDate,
    DateTime upperRecordDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'recordDate',
        lower: [lowerRecordDate],
        includeLower: includeLower,
        upper: [upperRecordDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeightRecordQueryFilter
    on QueryBuilder<WeightRecord, WeightRecord, QFilterCondition> {
  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesGreaterThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesBetween(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesStartsWith(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesContains(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> notesMatches(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> petIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> petIdLessThan(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> petIdBetween(
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      recordDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
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

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> weightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition>
      weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterFilterCondition> weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WeightRecordQueryObject
    on QueryBuilder<WeightRecord, WeightRecord, QFilterCondition> {}

extension WeightRecordQueryLinks
    on QueryBuilder<WeightRecord, WeightRecord, QFilterCondition> {}

extension WeightRecordQuerySortBy
    on QueryBuilder<WeightRecord, WeightRecord, QSortBy> {
  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy>
      sortByRecordDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension WeightRecordQuerySortThenBy
    on QueryBuilder<WeightRecord, WeightRecord, QSortThenBy> {
  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy>
      thenByRecordDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordDate', Sort.desc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension WeightRecordQueryWhereDistinct
    on QueryBuilder<WeightRecord, WeightRecord, QDistinct> {
  QueryBuilder<WeightRecord, WeightRecord, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QDistinct> distinctByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petId');
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QDistinct> distinctByRecordDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordDate');
    });
  }

  QueryBuilder<WeightRecord, WeightRecord, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension WeightRecordQueryProperty
    on QueryBuilder<WeightRecord, WeightRecord, QQueryProperty> {
  QueryBuilder<WeightRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeightRecord, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<WeightRecord, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<WeightRecord, int, QQueryOperations> petIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petId');
    });
  }

  QueryBuilder<WeightRecord, DateTime, QQueryOperations> recordDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordDate');
    });
  }

  QueryBuilder<WeightRecord, double, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}
