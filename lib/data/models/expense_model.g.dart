// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExpenseCollection on Isar {
  IsarCollection<Expense> get expenses => this.collection();
}

const ExpenseSchema = CollectionSchema(
  name: r'Expense',
  id: -4604318666888508206,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.byte,
      enumMap: _ExpensecategoryEnumValueMap,
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
    r'expenseDate': PropertySchema(
      id: 4,
      name: r'expenseDate',
      type: IsarType.dateTime,
    ),
    r'petId': PropertySchema(
      id: 5,
      name: r'petId',
      type: IsarType.long,
    ),
    r'receiptPath': PropertySchema(
      id: 6,
      name: r'receiptPath',
      type: IsarType.string,
    ),
    r'vendor': PropertySchema(
      id: 7,
      name: r'vendor',
      type: IsarType.string,
    )
  },
  estimateSize: _expenseEstimateSize,
  serialize: _expenseSerialize,
  deserialize: _expenseDeserialize,
  deserializeProp: _expenseDeserializeProp,
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
    r'expenseDate': IndexSchema(
      id: -472364015555664967,
      name: r'expenseDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'expenseDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _expenseGetId,
  getLinks: _expenseGetLinks,
  attach: _expenseAttach,
  version: '3.1.0+1',
);

int _expenseEstimateSize(
  Expense object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.receiptPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.vendor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _expenseSerialize(
  Expense object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeByte(offsets[1], object.category.index);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.description);
  writer.writeDateTime(offsets[4], object.expenseDate);
  writer.writeLong(offsets[5], object.petId);
  writer.writeString(offsets[6], object.receiptPath);
  writer.writeString(offsets[7], object.vendor);
}

Expense _expenseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Expense();
  object.amount = reader.readDouble(offsets[0]);
  object.category =
      _ExpensecategoryValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          ExpenseCategory.food;
  object.createdAt = reader.readDateTime(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.expenseDate = reader.readDateTime(offsets[4]);
  object.id = id;
  object.petId = reader.readLong(offsets[5]);
  object.receiptPath = reader.readStringOrNull(offsets[6]);
  object.vendor = reader.readStringOrNull(offsets[7]);
  return object;
}

P _expenseDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (_ExpensecategoryValueEnumMap[reader.readByteOrNull(offset)] ??
          ExpenseCategory.food) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ExpensecategoryEnumValueMap = {
  'food': 0,
  'vet': 1,
  'medication': 2,
  'supplies': 3,
  'grooming': 4,
  'insurance': 5,
  'training': 6,
  'toys': 7,
  'accessories': 8,
  'other': 9,
};
const _ExpensecategoryValueEnumMap = {
  0: ExpenseCategory.food,
  1: ExpenseCategory.vet,
  2: ExpenseCategory.medication,
  3: ExpenseCategory.supplies,
  4: ExpenseCategory.grooming,
  5: ExpenseCategory.insurance,
  6: ExpenseCategory.training,
  7: ExpenseCategory.toys,
  8: ExpenseCategory.accessories,
  9: ExpenseCategory.other,
};

Id _expenseGetId(Expense object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _expenseGetLinks(Expense object) {
  return [];
}

void _expenseAttach(IsarCollection<dynamic> col, Id id, Expense object) {
  object.id = id;
}

extension ExpenseQueryWhereSort on QueryBuilder<Expense, Expense, QWhere> {
  QueryBuilder<Expense, Expense, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhere> anyPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'petId'),
      );
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhere> anyExpenseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'expenseDate'),
      );
    });
  }
}

extension ExpenseQueryWhere on QueryBuilder<Expense, Expense, QWhereClause> {
  QueryBuilder<Expense, Expense, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> idBetween(
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> petIdEqualTo(int petId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'petId',
        value: [petId],
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> petIdNotEqualTo(int petId) {
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> petIdGreaterThan(
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> petIdLessThan(
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> petIdBetween(
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

  QueryBuilder<Expense, Expense, QAfterWhereClause> expenseDateEqualTo(
      DateTime expenseDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'expenseDate',
        value: [expenseDate],
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> expenseDateNotEqualTo(
      DateTime expenseDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expenseDate',
              lower: [],
              upper: [expenseDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expenseDate',
              lower: [expenseDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expenseDate',
              lower: [expenseDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'expenseDate',
              lower: [],
              upper: [expenseDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> expenseDateGreaterThan(
    DateTime expenseDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expenseDate',
        lower: [expenseDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> expenseDateLessThan(
    DateTime expenseDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expenseDate',
        lower: [],
        upper: [expenseDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterWhereClause> expenseDateBetween(
    DateTime lowerExpenseDate,
    DateTime upperExpenseDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'expenseDate',
        lower: [lowerExpenseDate],
        includeLower: includeLower,
        upper: [upperExpenseDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExpenseQueryFilter
    on QueryBuilder<Expense, Expense, QFilterCondition> {
  QueryBuilder<Expense, Expense, QAfterFilterCondition> amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> categoryEqualTo(
      ExpenseCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> categoryGreaterThan(
    ExpenseCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> categoryLessThan(
    ExpenseCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> categoryBetween(
    ExpenseCategory lower,
    ExpenseCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionGreaterThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> expenseDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> expenseDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expenseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> expenseDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expenseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> expenseDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expenseDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> petIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'petId',
        value: value,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> petIdGreaterThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> petIdLessThan(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> petIdBetween(
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

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receiptPath',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receiptPath',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receiptPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receiptPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receiptPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> receiptPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receiptPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition>
      receiptPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receiptPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'vendor',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'vendor',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vendor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vendor',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vendor',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendor',
        value: '',
      ));
    });
  }

  QueryBuilder<Expense, Expense, QAfterFilterCondition> vendorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vendor',
        value: '',
      ));
    });
  }
}

extension ExpenseQueryObject
    on QueryBuilder<Expense, Expense, QFilterCondition> {}

extension ExpenseQueryLinks
    on QueryBuilder<Expense, Expense, QFilterCondition> {}

extension ExpenseQuerySortBy on QueryBuilder<Expense, Expense, QSortBy> {
  QueryBuilder<Expense, Expense, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByExpenseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseDate', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByExpenseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseDate', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByReceiptPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByReceiptPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByVendor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendor', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> sortByVendorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendor', Sort.desc);
    });
  }
}

extension ExpenseQuerySortThenBy
    on QueryBuilder<Expense, Expense, QSortThenBy> {
  QueryBuilder<Expense, Expense, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByExpenseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseDate', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByExpenseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenseDate', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByPetIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'petId', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByReceiptPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByReceiptPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receiptPath', Sort.desc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByVendor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendor', Sort.asc);
    });
  }

  QueryBuilder<Expense, Expense, QAfterSortBy> thenByVendorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendor', Sort.desc);
    });
  }
}

extension ExpenseQueryWhereDistinct
    on QueryBuilder<Expense, Expense, QDistinct> {
  QueryBuilder<Expense, Expense, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category');
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByExpenseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expenseDate');
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByPetId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'petId');
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByReceiptPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receiptPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Expense, Expense, QDistinct> distinctByVendor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vendor', caseSensitive: caseSensitive);
    });
  }
}

extension ExpenseQueryProperty
    on QueryBuilder<Expense, Expense, QQueryProperty> {
  QueryBuilder<Expense, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Expense, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<Expense, ExpenseCategory, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Expense, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Expense, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Expense, DateTime, QQueryOperations> expenseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenseDate');
    });
  }

  QueryBuilder<Expense, int, QQueryOperations> petIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'petId');
    });
  }

  QueryBuilder<Expense, String?, QQueryOperations> receiptPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receiptPath');
    });
  }

  QueryBuilder<Expense, String?, QQueryOperations> vendorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vendor');
    });
  }
}
