// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPetCollection on Isar {
  IsarCollection<Pet> get pets => this.collection();
}

const PetSchema = CollectionSchema(
  name: r'Pet',
  id: -3474098573532960102,
  properties: {
    r'ageDisplay': PropertySchema(
      id: 0,
      name: r'ageDisplay',
      type: IsarType.string,
    ),
    r'ageInMonths': PropertySchema(
      id: 1,
      name: r'ageInMonths',
      type: IsarType.long,
    ),
    r'breed': PropertySchema(
      id: 2,
      name: r'breed',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateOfBirth': PropertySchema(
      id: 4,
      name: r'dateOfBirth',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'photoPath': PropertySchema(
      id: 6,
      name: r'photoPath',
      type: IsarType.string,
    ),
    r'species': PropertySchema(
      id: 7,
      name: r'species',
      type: IsarType.byte,
      enumMap: _PetspeciesEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weight': PropertySchema(
      id: 9,
      name: r'weight',
      type: IsarType.double,
    )
  },
  estimateSize: _petEstimateSize,
  serialize: _petSerialize,
  deserialize: _petDeserialize,
  deserializeProp: _petDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _petGetId,
  getLinks: _petGetLinks,
  attach: _petAttach,
  version: '3.1.0+1',
);

int _petEstimateSize(
  Pet object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ageDisplay;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.breed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.photoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _petSerialize(
  Pet object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ageDisplay);
  writer.writeLong(offsets[1], object.ageInMonths);
  writer.writeString(offsets[2], object.breed);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeDateTime(offsets[4], object.dateOfBirth);
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.photoPath);
  writer.writeByte(offsets[7], object.species.index);
  writer.writeDateTime(offsets[8], object.updatedAt);
  writer.writeDouble(offsets[9], object.weight);
}

Pet _petDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Pet();
  object.breed = reader.readStringOrNull(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.dateOfBirth = reader.readDateTimeOrNull(offsets[4]);
  object.id = id;
  object.name = reader.readString(offsets[5]);
  object.photoPath = reader.readStringOrNull(offsets[6]);
  object.species = _PetspeciesValueEnumMap[reader.readByteOrNull(offsets[7])] ??
      PetSpecies.dog;
  object.updatedAt = reader.readDateTime(offsets[8]);
  object.weight = reader.readDoubleOrNull(offsets[9]);
  return object;
}

P _petDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_PetspeciesValueEnumMap[reader.readByteOrNull(offset)] ??
          PetSpecies.dog) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PetspeciesEnumValueMap = {
  'dog': 0,
  'cat': 1,
  'bird': 2,
  'fish': 3,
  'rabbit': 4,
  'hamster': 5,
  'guineaPig': 6,
  'turtle': 7,
  'snake': 8,
  'other': 9,
};
const _PetspeciesValueEnumMap = {
  0: PetSpecies.dog,
  1: PetSpecies.cat,
  2: PetSpecies.bird,
  3: PetSpecies.fish,
  4: PetSpecies.rabbit,
  5: PetSpecies.hamster,
  6: PetSpecies.guineaPig,
  7: PetSpecies.turtle,
  8: PetSpecies.snake,
  9: PetSpecies.other,
};

Id _petGetId(Pet object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _petGetLinks(Pet object) {
  return [];
}

void _petAttach(IsarCollection<dynamic> col, Id id, Pet object) {
  object.id = id;
}

extension PetQueryWhereSort on QueryBuilder<Pet, Pet, QWhere> {
  QueryBuilder<Pet, Pet, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PetQueryWhere on QueryBuilder<Pet, Pet, QWhereClause> {
  QueryBuilder<Pet, Pet, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Pet, Pet, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Pet, Pet, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Pet, Pet, QAfterWhereClause> idBetween(
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
}

extension PetQueryFilter on QueryBuilder<Pet, Pet, QFilterCondition> {
  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ageDisplay',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ageDisplay',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ageDisplay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ageDisplay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ageDisplay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ageDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageDisplayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ageDisplay',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ageInMonths',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ageInMonths',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ageInMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ageInMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ageInMonths',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> ageInMonthsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ageInMonths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'breed',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'breed',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'breed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'breed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> breedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'breed',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOfBirth',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOfBirth',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> dateOfBirthBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOfBirth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> photoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> speciesEqualTo(
      PetSpecies value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'species',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> speciesGreaterThan(
    PetSpecies value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'species',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> speciesLessThan(
    PetSpecies value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'species',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> speciesBetween(
    PetSpecies lower,
    PetSpecies upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'species',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weight',
      ));
    });
  }

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightEqualTo(
    double? value, {
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightGreaterThan(
    double? value, {
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightLessThan(
    double? value, {
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

  QueryBuilder<Pet, Pet, QAfterFilterCondition> weightBetween(
    double? lower,
    double? upper, {
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

extension PetQueryObject on QueryBuilder<Pet, Pet, QFilterCondition> {}

extension PetQueryLinks on QueryBuilder<Pet, Pet, QFilterCondition> {}

extension PetQuerySortBy on QueryBuilder<Pet, Pet, QSortBy> {
  QueryBuilder<Pet, Pet, QAfterSortBy> sortByAgeDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageDisplay', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByAgeDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageDisplay', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByAgeInMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageInMonths', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByAgeInMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageInMonths', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension PetQuerySortThenBy on QueryBuilder<Pet, Pet, QSortThenBy> {
  QueryBuilder<Pet, Pet, QAfterSortBy> thenByAgeDisplay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageDisplay', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByAgeDisplayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageDisplay', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByAgeInMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageInMonths', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByAgeInMonthsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ageInMonths', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByBreed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByBreedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breed', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByDateOfBirthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOfBirth', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenBySpeciesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'species', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<Pet, Pet, QAfterSortBy> thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }
}

extension PetQueryWhereDistinct on QueryBuilder<Pet, Pet, QDistinct> {
  QueryBuilder<Pet, Pet, QDistinct> distinctByAgeDisplay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ageDisplay', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByAgeInMonths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ageInMonths');
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByBreed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByDateOfBirth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOfBirth');
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctBySpecies() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'species');
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Pet, Pet, QDistinct> distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }
}

extension PetQueryProperty on QueryBuilder<Pet, Pet, QQueryProperty> {
  QueryBuilder<Pet, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Pet, String?, QQueryOperations> ageDisplayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ageDisplay');
    });
  }

  QueryBuilder<Pet, int?, QQueryOperations> ageInMonthsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ageInMonths');
    });
  }

  QueryBuilder<Pet, String?, QQueryOperations> breedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breed');
    });
  }

  QueryBuilder<Pet, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Pet, DateTime?, QQueryOperations> dateOfBirthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOfBirth');
    });
  }

  QueryBuilder<Pet, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Pet, String?, QQueryOperations> photoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPath');
    });
  }

  QueryBuilder<Pet, PetSpecies, QQueryOperations> speciesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'species');
    });
  }

  QueryBuilder<Pet, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Pet, double?, QQueryOperations> weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }
}
