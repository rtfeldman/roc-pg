# Derived from PostgreSQL 18.6, src/backend/parser/gram.y and the node
# headers and functions it uses.
#
# PostgreSQL Database Management System
# (also known as Postgres, formerly known as Postgres95)
#
# Portions Copyright (c) 1996-2026, PostgreSQL Global Development Group
#
# Portions Copyright (c) 1994, The Regents of the University of California
#
# Permission to use, copy, modify, and distribute this software and its
# documentation for any purpose, without fee, and without a written agreement
# is hereby granted, provided that the above copyright notice and this
# paragraph and the following two paragraphs appear in all copies.
#
# IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
# LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
# DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
# ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
# PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

## The nodes of Postgres 18.6's raw parse tree, one tag per node type of
## `src/include/nodes`, with the node's fields as a record. A pointer to
## a node is a `Node`, with `Null` for NULL; a `List *` is a list, empty
## for NIL; a `char *` is a `Node.Text`. Written by `tools/actions.roc`,
## do not edit.
Node := [
	Null,
	NodeList(List(Node)),
	ATAlterConstraint(Node.ATAlterConstraint),
	AArrayExpr(Node.AArrayExpr),
	AConst(Node.AConst),
	AExpr(Node.AExpr),
	AIndices(Node.AIndices),
	AIndirection(Node.AIndirection),
	AStar(Node.AStar),
	AccessPriv(Node.AccessPriv),
	Alias(Node.Alias),
	AlterCollationStmt(Node.AlterCollationStmt),
	AlterDatabaseRefreshCollStmt(Node.AlterDatabaseRefreshCollStmt),
	AlterDatabaseSetStmt(Node.AlterDatabaseSetStmt),
	AlterDatabaseStmt(Node.AlterDatabaseStmt),
	AlterDefaultPrivilegesStmt(Node.AlterDefaultPrivilegesStmt),
	AlterDomainStmt(Node.AlterDomainStmt),
	AlterEnumStmt(Node.AlterEnumStmt),
	AlterEventTrigStmt(Node.AlterEventTrigStmt),
	AlterExtensionContentsStmt(Node.AlterExtensionContentsStmt),
	AlterExtensionStmt(Node.AlterExtensionStmt),
	AlterFdwStmt(Node.AlterFdwStmt),
	AlterForeignServerStmt(Node.AlterForeignServerStmt),
	AlterFunctionStmt(Node.AlterFunctionStmt),
	AlterObjectDependsStmt(Node.AlterObjectDependsStmt),
	AlterObjectSchemaStmt(Node.AlterObjectSchemaStmt),
	AlterOpFamilyStmt(Node.AlterOpFamilyStmt),
	AlterOperatorStmt(Node.AlterOperatorStmt),
	AlterOwnerStmt(Node.AlterOwnerStmt),
	AlterPolicyStmt(Node.AlterPolicyStmt),
	AlterPublicationStmt(Node.AlterPublicationStmt),
	AlterRoleSetStmt(Node.AlterRoleSetStmt),
	AlterRoleStmt(Node.AlterRoleStmt),
	AlterSeqStmt(Node.AlterSeqStmt),
	AlterStatsStmt(Node.AlterStatsStmt),
	AlterSubscriptionStmt(Node.AlterSubscriptionStmt),
	AlterSystemStmt(Node.AlterSystemStmt),
	AlterTSConfigurationStmt(Node.AlterTSConfigurationStmt),
	AlterTSDictionaryStmt(Node.AlterTSDictionaryStmt),
	AlterTableCmd(Node.AlterTableCmd),
	AlterTableMoveAllStmt(Node.AlterTableMoveAllStmt),
	AlterTableSpaceOptionsStmt(Node.AlterTableSpaceOptionsStmt),
	AlterTableStmt(Node.AlterTableStmt),
	AlterTypeStmt(Node.AlterTypeStmt),
	AlterUserMappingStmt(Node.AlterUserMappingStmt),
	BitString(Node.BitString),
	BoolExpr(Node.BoolExpr),
	Boolean(Node.Boolean),
	BooleanTest(Node.BooleanTest),
	CTECycleClause(Node.CTECycleClause),
	CTESearchClause(Node.CTESearchClause),
	CallStmt(Node.CallStmt),
	CaseExpr(Node.CaseExpr),
	CaseWhen(Node.CaseWhen),
	CheckPointStmt(Node.CheckPointStmt),
	ClosePortalStmt(Node.ClosePortalStmt),
	ClusterStmt(Node.ClusterStmt),
	CoalesceExpr(Node.CoalesceExpr),
	CollateClause(Node.CollateClause),
	ColumnDef(Node.ColumnDef),
	ColumnRef(Node.ColumnRef),
	CommentStmt(Node.CommentStmt),
	CommonTableExpr(Node.CommonTableExpr),
	CompositeTypeStmt(Node.CompositeTypeStmt),
	Constraint(Node.Constraint),
	ConstraintsSetStmt(Node.ConstraintsSetStmt),
	CopyStmt(Node.CopyStmt),
	CreateAmStmt(Node.CreateAmStmt),
	CreateCastStmt(Node.CreateCastStmt),
	CreateConversionStmt(Node.CreateConversionStmt),
	CreateDomainStmt(Node.CreateDomainStmt),
	CreateEnumStmt(Node.CreateEnumStmt),
	CreateEventTrigStmt(Node.CreateEventTrigStmt),
	CreateExtensionStmt(Node.CreateExtensionStmt),
	CreateFdwStmt(Node.CreateFdwStmt),
	CreateForeignServerStmt(Node.CreateForeignServerStmt),
	CreateForeignTableStmt(Node.CreateForeignTableStmt),
	CreateFunctionStmt(Node.CreateFunctionStmt),
	CreateOpClassItem(Node.CreateOpClassItem),
	CreateOpClassStmt(Node.CreateOpClassStmt),
	CreateOpFamilyStmt(Node.CreateOpFamilyStmt),
	CreatePLangStmt(Node.CreatePLangStmt),
	CreatePolicyStmt(Node.CreatePolicyStmt),
	CreatePublicationStmt(Node.CreatePublicationStmt),
	CreateRangeStmt(Node.CreateRangeStmt),
	CreateRoleStmt(Node.CreateRoleStmt),
	CreateSchemaStmt(Node.CreateSchemaStmt),
	CreateSeqStmt(Node.CreateSeqStmt),
	CreateStatsStmt(Node.CreateStatsStmt),
	CreateStmt(Node.CreateStmt),
	CreateSubscriptionStmt(Node.CreateSubscriptionStmt),
	CreateTableAsStmt(Node.CreateTableAsStmt),
	CreateTableSpaceStmt(Node.CreateTableSpaceStmt),
	CreateTransformStmt(Node.CreateTransformStmt),
	CreateTrigStmt(Node.CreateTrigStmt),
	CreateUserMappingStmt(Node.CreateUserMappingStmt),
	CreatedbStmt(Node.CreatedbStmt),
	CurrentOfExpr(Node.CurrentOfExpr),
	DeallocateStmt(Node.DeallocateStmt),
	DeclareCursorStmt(Node.DeclareCursorStmt),
	DefElem(Node.DefElem),
	DefineStmt(Node.DefineStmt),
	DeleteStmt(Node.DeleteStmt),
	DiscardStmt(Node.DiscardStmt),
	DoStmt(Node.DoStmt),
	DropOwnedStmt(Node.DropOwnedStmt),
	DropRoleStmt(Node.DropRoleStmt),
	DropStmt(Node.DropStmt),
	DropSubscriptionStmt(Node.DropSubscriptionStmt),
	DropTableSpaceStmt(Node.DropTableSpaceStmt),
	DropUserMappingStmt(Node.DropUserMappingStmt),
	DropdbStmt(Node.DropdbStmt),
	ExecuteStmt(Node.ExecuteStmt),
	ExplainStmt(Node.ExplainStmt),
	FetchStmt(Node.FetchStmt),
	Float(Node.Float),
	FuncCall(Node.FuncCall),
	FunctionParameter(Node.FunctionParameter),
	GrantRoleStmt(Node.GrantRoleStmt),
	GrantStmt(Node.GrantStmt),
	GroupClause(Node.GroupClause),
	GroupingFunc(Node.GroupingFunc),
	GroupingSet(Node.GroupingSet),
	ImportForeignSchemaStmt(Node.ImportForeignSchemaStmt),
	ImportQual(Node.ImportQual),
	IndexElem(Node.IndexElem),
	IndexStmt(Node.IndexStmt),
	InferClause(Node.InferClause),
	InsertStmt(Node.InsertStmt),
	Integer(Node.Integer),
	IntoClause(Node.IntoClause),
	JoinExpr(Node.JoinExpr),
	JsonAggConstructor(Node.JsonAggConstructor),
	JsonArgument(Node.JsonArgument),
	JsonArrayAgg(Node.JsonArrayAgg),
	JsonArrayConstructor(Node.JsonArrayConstructor),
	JsonArrayQueryConstructor(Node.JsonArrayQueryConstructor),
	JsonBehavior(Node.JsonBehavior),
	JsonFormat(Node.JsonFormat),
	JsonFuncExpr(Node.JsonFuncExpr),
	JsonIsPredicate(Node.JsonIsPredicate),
	JsonKeyValue(Node.JsonKeyValue),
	JsonObjectAgg(Node.JsonObjectAgg),
	JsonObjectConstructor(Node.JsonObjectConstructor),
	JsonOutput(Node.JsonOutput),
	JsonParseExpr(Node.JsonParseExpr),
	JsonReturning(Node.JsonReturning),
	JsonScalarExpr(Node.JsonScalarExpr),
	JsonSerializeExpr(Node.JsonSerializeExpr),
	JsonTable(Node.JsonTable),
	JsonTableColumn(Node.JsonTableColumn),
	JsonTablePathSpec(Node.JsonTablePathSpec),
	JsonValueExpr(Node.JsonValueExpr),
	KeyAction(Node.KeyAction),
	KeyActions(Node.KeyActions),
	ListenStmt(Node.ListenStmt),
	LoadStmt(Node.LoadStmt),
	LockStmt(Node.LockStmt),
	LockingClause(Node.LockingClause),
	MergeStmt(Node.MergeStmt),
	MergeSupportFunc(Node.MergeSupportFunc),
	MergeWhenClause(Node.MergeWhenClause),
	MinMaxExpr(Node.MinMaxExpr),
	MultiAssignRef(Node.MultiAssignRef),
	NamedArgExpr(Node.NamedArgExpr),
	NotifyStmt(Node.NotifyStmt),
	NullTest(Node.NullTest),
	ObjectWithArgs(Node.ObjectWithArgs),
	OnConflictClause(Node.OnConflictClause),
	PLAssignStmt(Node.PLAssignStmt),
	ParamRef(Node.ParamRef),
	PartitionBoundSpec(Node.PartitionBoundSpec),
	PartitionCmd(Node.PartitionCmd),
	PartitionElem(Node.PartitionElem),
	PartitionSpec(Node.PartitionSpec),
	PrepareStmt(Node.PrepareStmt),
	PrivTarget(Node.PrivTarget),
	PublicationObjSpec(Node.PublicationObjSpec),
	PublicationTable(Node.PublicationTable),
	RangeFunction(Node.RangeFunction),
	RangeSubselect(Node.RangeSubselect),
	RangeTableFunc(Node.RangeTableFunc),
	RangeTableFuncCol(Node.RangeTableFuncCol),
	RangeTableSample(Node.RangeTableSample),
	RangeVar(Node.RangeVar),
	RawStmt(Node.RawStmt),
	ReassignOwnedStmt(Node.ReassignOwnedStmt),
	RefreshMatViewStmt(Node.RefreshMatViewStmt),
	ReindexStmt(Node.ReindexStmt),
	RenameStmt(Node.RenameStmt),
	ReplicaIdentityStmt(Node.ReplicaIdentityStmt),
	ResTarget(Node.ResTarget),
	ReturnStmt(Node.ReturnStmt),
	ReturningClause(Node.ReturningClause),
	ReturningOption(Node.ReturningOption),
	RoleSpec(Node.RoleSpec),
	RowExpr(Node.RowExpr),
	RuleStmt(Node.RuleStmt),
	SQLValueFunction(Node.SQLValueFunction),
	SecLabelStmt(Node.SecLabelStmt),
	SelectLimit(Node.SelectLimit),
	SelectStmt(Node.SelectStmt),
	SetToDefault(Node.SetToDefault),
	SortBy(Node.SortBy),
	StatsElem(Node.StatsElem),
	String(Node.String),
	SubLink(Node.SubLink),
	TableLikeClause(Node.TableLikeClause),
	TransactionStmt(Node.TransactionStmt),
	TriggerTransition(Node.TriggerTransition),
	TruncateStmt(Node.TruncateStmt),
	TypeCast(Node.TypeCast),
	TypeName(Node.TypeName),
	UnlistenStmt(Node.UnlistenStmt),
	UpdateStmt(Node.UpdateStmt),
	VacuumRelation(Node.VacuumRelation),
	VacuumStmt(Node.VacuumStmt),
	VariableSetStmt(Node.VariableSetStmt),
	VariableShowStmt(Node.VariableShowStmt),
	ViewStmt(Node.ViewStmt),
	WindowDef(Node.WindowDef),
	WithClause(Node.WithClause),
	XmlExpr(Node.XmlExpr),
	XmlSerialize(Node.XmlSerialize),
].{
	## The immutable null node, shared by record defaults.
	null : Node
	null = Null

	## A `char *`: the text, or NULL.
	Text : Try(Str, [Null])

	## `ATAlterConstraint`
	ATAlterConstraint : { conname : Node.Text, alter_enforceability : Bool, is_enforced : Bool, alter_deferrability : Bool, deferrable : Bool, initdeferred : Bool, alter_inheritability : Bool, noinherit : Bool }

	at_alter_constraint_default : Node.ATAlterConstraint
	at_alter_constraint_default = { conname: Err(Null), alter_enforceability: Bool.False, is_enforced: Bool.False, alter_deferrability: Bool.False, deferrable: Bool.False, initdeferred: Bool.False, alter_inheritability: Bool.False, noinherit: Bool.False }

	at_alter_constraint_of : Node -> Node.ATAlterConstraint
	at_alter_constraint_of = |n|
		match n {
			ATAlterConstraint(r) => r
			_ => crash "expected ATAlterConstraint, got ${Node.tag(n)}"
		}

	## `A_ArrayExpr`
	AArrayExpr : { elements : List(Node), list_start : I64, list_end : I64, location : I64 }

	a_array_expr_default : Node.AArrayExpr
	a_array_expr_default = { elements: [], list_start: 0.I64, list_end: 0.I64, location: 0.I64 }

	a_array_expr_of : Node -> Node.AArrayExpr
	a_array_expr_of = |n|
		match n {
			AArrayExpr(r) => r
			_ => crash "expected A_ArrayExpr, got ${Node.tag(n)}"
		}

	## `A_Const`
	AConst : { val : Node, isnull : Bool, location : I64 }

	a_const_default : Node.AConst
	a_const_default = { val: Node.null, isnull: Bool.False, location: 0.I64 }

	a_const_of : Node -> Node.AConst
	a_const_of = |n|
		match n {
			AConst(r) => r
			_ => crash "expected A_Const, got ${Node.tag(n)}"
		}

	## `A_Expr`
	AExpr : { kind : I64, name : List(Node), lexpr : Node, rexpr : Node, rexpr_list_start : I64, rexpr_list_end : I64, location : I64 }

	a_expr_default : Node.AExpr
	a_expr_default = { kind: 0.I64, name: [], lexpr: Node.null, rexpr: Node.null, rexpr_list_start: 0.I64, rexpr_list_end: 0.I64, location: 0.I64 }

	a_expr_of : Node -> Node.AExpr
	a_expr_of = |n|
		match n {
			AExpr(r) => r
			_ => crash "expected A_Expr, got ${Node.tag(n)}"
		}

	## `A_Indices`
	AIndices : { is_slice : Bool, lidx : Node, uidx : Node }

	a_indices_default : Node.AIndices
	a_indices_default = { is_slice: Bool.False, lidx: Node.null, uidx: Node.null }

	a_indices_of : Node -> Node.AIndices
	a_indices_of = |n|
		match n {
			AIndices(r) => r
			_ => crash "expected A_Indices, got ${Node.tag(n)}"
		}

	## `A_Indirection`
	AIndirection : { arg : Node, indirection : List(Node) }

	a_indirection_default : Node.AIndirection
	a_indirection_default = { arg: Node.null, indirection: [] }

	a_indirection_of : Node -> Node.AIndirection
	a_indirection_of = |n|
		match n {
			AIndirection(r) => r
			_ => crash "expected A_Indirection, got ${Node.tag(n)}"
		}

	## `A_Star`
	AStar : {}

	a_star_default : Node.AStar
	a_star_default = {}

	a_star_of : Node -> Node.AStar
	a_star_of = |n|
		match n {
			AStar(r) => r
			_ => crash "expected A_Star, got ${Node.tag(n)}"
		}

	## `AccessPriv`
	AccessPriv : { priv_name : Node.Text, cols : List(Node) }

	access_priv_default : Node.AccessPriv
	access_priv_default = { priv_name: Err(Null), cols: [] }

	access_priv_of : Node -> Node.AccessPriv
	access_priv_of = |n|
		match n {
			AccessPriv(r) => r
			_ => crash "expected AccessPriv, got ${Node.tag(n)}"
		}

	## `Alias`
	Alias : { aliasname : Node.Text, colnames : List(Node) }

	alias_default : Node.Alias
	alias_default = { aliasname: Err(Null), colnames: [] }

	alias_of : Node -> Node.Alias
	alias_of = |n|
		match n {
			Alias(r) => r
			_ => crash "expected Alias, got ${Node.tag(n)}"
		}

	## `AlterCollationStmt`
	AlterCollationStmt : { collname : List(Node) }

	alter_collation_stmt_default : Node.AlterCollationStmt
	alter_collation_stmt_default = { collname: [] }

	alter_collation_stmt_of : Node -> Node.AlterCollationStmt
	alter_collation_stmt_of = |n|
		match n {
			AlterCollationStmt(r) => r
			_ => crash "expected AlterCollationStmt, got ${Node.tag(n)}"
		}

	## `AlterDatabaseRefreshCollStmt`
	AlterDatabaseRefreshCollStmt : { dbname : Node.Text }

	alter_database_refresh_coll_stmt_default : Node.AlterDatabaseRefreshCollStmt
	alter_database_refresh_coll_stmt_default = { dbname: Err(Null) }

	alter_database_refresh_coll_stmt_of : Node -> Node.AlterDatabaseRefreshCollStmt
	alter_database_refresh_coll_stmt_of = |n|
		match n {
			AlterDatabaseRefreshCollStmt(r) => r
			_ => crash "expected AlterDatabaseRefreshCollStmt, got ${Node.tag(n)}"
		}

	## `AlterDatabaseSetStmt`
	AlterDatabaseSetStmt : { dbname : Node.Text, setstmt : Node }

	alter_database_set_stmt_default : Node.AlterDatabaseSetStmt
	alter_database_set_stmt_default = { dbname: Err(Null), setstmt: Node.null }

	alter_database_set_stmt_of : Node -> Node.AlterDatabaseSetStmt
	alter_database_set_stmt_of = |n|
		match n {
			AlterDatabaseSetStmt(r) => r
			_ => crash "expected AlterDatabaseSetStmt, got ${Node.tag(n)}"
		}

	## `AlterDatabaseStmt`
	AlterDatabaseStmt : { dbname : Node.Text, options : List(Node) }

	alter_database_stmt_default : Node.AlterDatabaseStmt
	alter_database_stmt_default = { dbname: Err(Null), options: [] }

	alter_database_stmt_of : Node -> Node.AlterDatabaseStmt
	alter_database_stmt_of = |n|
		match n {
			AlterDatabaseStmt(r) => r
			_ => crash "expected AlterDatabaseStmt, got ${Node.tag(n)}"
		}

	## `AlterDefaultPrivilegesStmt`
	AlterDefaultPrivilegesStmt : { options : List(Node), action : Node }

	alter_default_privileges_stmt_default : Node.AlterDefaultPrivilegesStmt
	alter_default_privileges_stmt_default = { options: [], action: Node.null }

	alter_default_privileges_stmt_of : Node -> Node.AlterDefaultPrivilegesStmt
	alter_default_privileges_stmt_of = |n|
		match n {
			AlterDefaultPrivilegesStmt(r) => r
			_ => crash "expected AlterDefaultPrivilegesStmt, got ${Node.tag(n)}"
		}

	## `AlterDomainStmt`
	AlterDomainStmt : { subtype : I64, type_name : List(Node), name : Node.Text, def : Node, behavior : I64, missing_ok : Bool }

	alter_domain_stmt_default : Node.AlterDomainStmt
	alter_domain_stmt_default = { subtype: 0.I64, type_name: [], name: Err(Null), def: Node.null, behavior: 0.I64, missing_ok: Bool.False }

	alter_domain_stmt_of : Node -> Node.AlterDomainStmt
	alter_domain_stmt_of = |n|
		match n {
			AlterDomainStmt(r) => r
			_ => crash "expected AlterDomainStmt, got ${Node.tag(n)}"
		}

	## `AlterEnumStmt`
	AlterEnumStmt : { type_name : List(Node), old_val : Node.Text, new_val : Node.Text, new_val_neighbor : Node.Text, new_val_is_after : Bool, skip_if_new_val_exists : Bool }

	alter_enum_stmt_default : Node.AlterEnumStmt
	alter_enum_stmt_default = { type_name: [], old_val: Err(Null), new_val: Err(Null), new_val_neighbor: Err(Null), new_val_is_after: Bool.False, skip_if_new_val_exists: Bool.False }

	alter_enum_stmt_of : Node -> Node.AlterEnumStmt
	alter_enum_stmt_of = |n|
		match n {
			AlterEnumStmt(r) => r
			_ => crash "expected AlterEnumStmt, got ${Node.tag(n)}"
		}

	## `AlterEventTrigStmt`
	AlterEventTrigStmt : { trigname : Node.Text, tgenabled : I64 }

	alter_event_trig_stmt_default : Node.AlterEventTrigStmt
	alter_event_trig_stmt_default = { trigname: Err(Null), tgenabled: 0.I64 }

	alter_event_trig_stmt_of : Node -> Node.AlterEventTrigStmt
	alter_event_trig_stmt_of = |n|
		match n {
			AlterEventTrigStmt(r) => r
			_ => crash "expected AlterEventTrigStmt, got ${Node.tag(n)}"
		}

	## `AlterExtensionContentsStmt`
	AlterExtensionContentsStmt : { extname : Node.Text, action : I64, objtype : I64, object : Node }

	alter_extension_contents_stmt_default : Node.AlterExtensionContentsStmt
	alter_extension_contents_stmt_default = { extname: Err(Null), action: 0.I64, objtype: 0.I64, object: Node.null }

	alter_extension_contents_stmt_of : Node -> Node.AlterExtensionContentsStmt
	alter_extension_contents_stmt_of = |n|
		match n {
			AlterExtensionContentsStmt(r) => r
			_ => crash "expected AlterExtensionContentsStmt, got ${Node.tag(n)}"
		}

	## `AlterExtensionStmt`
	AlterExtensionStmt : { extname : Node.Text, options : List(Node) }

	alter_extension_stmt_default : Node.AlterExtensionStmt
	alter_extension_stmt_default = { extname: Err(Null), options: [] }

	alter_extension_stmt_of : Node -> Node.AlterExtensionStmt
	alter_extension_stmt_of = |n|
		match n {
			AlterExtensionStmt(r) => r
			_ => crash "expected AlterExtensionStmt, got ${Node.tag(n)}"
		}

	## `AlterFdwStmt`
	AlterFdwStmt : { fdwname : Node.Text, func_options : List(Node), options : List(Node) }

	alter_fdw_stmt_default : Node.AlterFdwStmt
	alter_fdw_stmt_default = { fdwname: Err(Null), func_options: [], options: [] }

	alter_fdw_stmt_of : Node -> Node.AlterFdwStmt
	alter_fdw_stmt_of = |n|
		match n {
			AlterFdwStmt(r) => r
			_ => crash "expected AlterFdwStmt, got ${Node.tag(n)}"
		}

	## `AlterForeignServerStmt`
	AlterForeignServerStmt : { servername : Node.Text, version : Node.Text, options : List(Node), has_version : Bool }

	alter_foreign_server_stmt_default : Node.AlterForeignServerStmt
	alter_foreign_server_stmt_default = { servername: Err(Null), version: Err(Null), options: [], has_version: Bool.False }

	alter_foreign_server_stmt_of : Node -> Node.AlterForeignServerStmt
	alter_foreign_server_stmt_of = |n|
		match n {
			AlterForeignServerStmt(r) => r
			_ => crash "expected AlterForeignServerStmt, got ${Node.tag(n)}"
		}

	## `AlterFunctionStmt`
	AlterFunctionStmt : { objtype : I64, func : Node, actions : List(Node) }

	alter_function_stmt_default : Node.AlterFunctionStmt
	alter_function_stmt_default = { objtype: 0.I64, func: Node.null, actions: [] }

	alter_function_stmt_of : Node -> Node.AlterFunctionStmt
	alter_function_stmt_of = |n|
		match n {
			AlterFunctionStmt(r) => r
			_ => crash "expected AlterFunctionStmt, got ${Node.tag(n)}"
		}

	## `AlterObjectDependsStmt`
	AlterObjectDependsStmt : { object_type : I64, relation : Node, object : Node, extname : Node, remove : Bool }

	alter_object_depends_stmt_default : Node.AlterObjectDependsStmt
	alter_object_depends_stmt_default = { object_type: 0.I64, relation: Node.null, object: Node.null, extname: Node.null, remove: Bool.False }

	alter_object_depends_stmt_of : Node -> Node.AlterObjectDependsStmt
	alter_object_depends_stmt_of = |n|
		match n {
			AlterObjectDependsStmt(r) => r
			_ => crash "expected AlterObjectDependsStmt, got ${Node.tag(n)}"
		}

	## `AlterObjectSchemaStmt`
	AlterObjectSchemaStmt : { object_type : I64, relation : Node, object : Node, newschema : Node.Text, missing_ok : Bool }

	alter_object_schema_stmt_default : Node.AlterObjectSchemaStmt
	alter_object_schema_stmt_default = { object_type: 0.I64, relation: Node.null, object: Node.null, newschema: Err(Null), missing_ok: Bool.False }

	alter_object_schema_stmt_of : Node -> Node.AlterObjectSchemaStmt
	alter_object_schema_stmt_of = |n|
		match n {
			AlterObjectSchemaStmt(r) => r
			_ => crash "expected AlterObjectSchemaStmt, got ${Node.tag(n)}"
		}

	## `AlterOpFamilyStmt`
	AlterOpFamilyStmt : { opfamilyname : List(Node), amname : Node.Text, is_drop : Bool, items : List(Node) }

	alter_op_family_stmt_default : Node.AlterOpFamilyStmt
	alter_op_family_stmt_default = { opfamilyname: [], amname: Err(Null), is_drop: Bool.False, items: [] }

	alter_op_family_stmt_of : Node -> Node.AlterOpFamilyStmt
	alter_op_family_stmt_of = |n|
		match n {
			AlterOpFamilyStmt(r) => r
			_ => crash "expected AlterOpFamilyStmt, got ${Node.tag(n)}"
		}

	## `AlterOperatorStmt`
	AlterOperatorStmt : { opername : Node, options : List(Node) }

	alter_operator_stmt_default : Node.AlterOperatorStmt
	alter_operator_stmt_default = { opername: Node.null, options: [] }

	alter_operator_stmt_of : Node -> Node.AlterOperatorStmt
	alter_operator_stmt_of = |n|
		match n {
			AlterOperatorStmt(r) => r
			_ => crash "expected AlterOperatorStmt, got ${Node.tag(n)}"
		}

	## `AlterOwnerStmt`
	AlterOwnerStmt : { object_type : I64, relation : Node, object : Node, newowner : Node }

	alter_owner_stmt_default : Node.AlterOwnerStmt
	alter_owner_stmt_default = { object_type: 0.I64, relation: Node.null, object: Node.null, newowner: Node.null }

	alter_owner_stmt_of : Node -> Node.AlterOwnerStmt
	alter_owner_stmt_of = |n|
		match n {
			AlterOwnerStmt(r) => r
			_ => crash "expected AlterOwnerStmt, got ${Node.tag(n)}"
		}

	## `AlterPolicyStmt`
	AlterPolicyStmt : { policy_name : Node.Text, table : Node, roles : List(Node), qual : Node, with_check : Node }

	alter_policy_stmt_default : Node.AlterPolicyStmt
	alter_policy_stmt_default = { policy_name: Err(Null), table: Node.null, roles: [], qual: Node.null, with_check: Node.null }

	alter_policy_stmt_of : Node -> Node.AlterPolicyStmt
	alter_policy_stmt_of = |n|
		match n {
			AlterPolicyStmt(r) => r
			_ => crash "expected AlterPolicyStmt, got ${Node.tag(n)}"
		}

	## `AlterPublicationStmt`
	AlterPublicationStmt : { pubname : Node.Text, options : List(Node), pubobjects : List(Node), for_all_tables : Bool, action : I64 }

	alter_publication_stmt_default : Node.AlterPublicationStmt
	alter_publication_stmt_default = { pubname: Err(Null), options: [], pubobjects: [], for_all_tables: Bool.False, action: 0.I64 }

	alter_publication_stmt_of : Node -> Node.AlterPublicationStmt
	alter_publication_stmt_of = |n|
		match n {
			AlterPublicationStmt(r) => r
			_ => crash "expected AlterPublicationStmt, got ${Node.tag(n)}"
		}

	## `AlterRoleSetStmt`
	AlterRoleSetStmt : { role : Node, database : Node.Text, setstmt : Node }

	alter_role_set_stmt_default : Node.AlterRoleSetStmt
	alter_role_set_stmt_default = { role: Node.null, database: Err(Null), setstmt: Node.null }

	alter_role_set_stmt_of : Node -> Node.AlterRoleSetStmt
	alter_role_set_stmt_of = |n|
		match n {
			AlterRoleSetStmt(r) => r
			_ => crash "expected AlterRoleSetStmt, got ${Node.tag(n)}"
		}

	## `AlterRoleStmt`
	AlterRoleStmt : { role : Node, options : List(Node), action : I64 }

	alter_role_stmt_default : Node.AlterRoleStmt
	alter_role_stmt_default = { role: Node.null, options: [], action: 0.I64 }

	alter_role_stmt_of : Node -> Node.AlterRoleStmt
	alter_role_stmt_of = |n|
		match n {
			AlterRoleStmt(r) => r
			_ => crash "expected AlterRoleStmt, got ${Node.tag(n)}"
		}

	## `AlterSeqStmt`
	AlterSeqStmt : { sequence : Node, options : List(Node), for_identity : Bool, missing_ok : Bool }

	alter_seq_stmt_default : Node.AlterSeqStmt
	alter_seq_stmt_default = { sequence: Node.null, options: [], for_identity: Bool.False, missing_ok: Bool.False }

	alter_seq_stmt_of : Node -> Node.AlterSeqStmt
	alter_seq_stmt_of = |n|
		match n {
			AlterSeqStmt(r) => r
			_ => crash "expected AlterSeqStmt, got ${Node.tag(n)}"
		}

	## `AlterStatsStmt`
	AlterStatsStmt : { defnames : List(Node), stxstattarget : Node, missing_ok : Bool }

	alter_stats_stmt_default : Node.AlterStatsStmt
	alter_stats_stmt_default = { defnames: [], stxstattarget: Node.null, missing_ok: Bool.False }

	alter_stats_stmt_of : Node -> Node.AlterStatsStmt
	alter_stats_stmt_of = |n|
		match n {
			AlterStatsStmt(r) => r
			_ => crash "expected AlterStatsStmt, got ${Node.tag(n)}"
		}

	## `AlterSubscriptionStmt`
	AlterSubscriptionStmt : { kind : I64, subname : Node.Text, conninfo : Node.Text, publication : List(Node), options : List(Node) }

	alter_subscription_stmt_default : Node.AlterSubscriptionStmt
	alter_subscription_stmt_default = { kind: 0.I64, subname: Err(Null), conninfo: Err(Null), publication: [], options: [] }

	alter_subscription_stmt_of : Node -> Node.AlterSubscriptionStmt
	alter_subscription_stmt_of = |n|
		match n {
			AlterSubscriptionStmt(r) => r
			_ => crash "expected AlterSubscriptionStmt, got ${Node.tag(n)}"
		}

	## `AlterSystemStmt`
	AlterSystemStmt : { setstmt : Node }

	alter_system_stmt_default : Node.AlterSystemStmt
	alter_system_stmt_default = { setstmt: Node.null }

	alter_system_stmt_of : Node -> Node.AlterSystemStmt
	alter_system_stmt_of = |n|
		match n {
			AlterSystemStmt(r) => r
			_ => crash "expected AlterSystemStmt, got ${Node.tag(n)}"
		}

	## `AlterTSConfigurationStmt`
	AlterTSConfigurationStmt : { kind : I64, cfgname : List(Node), tokentype : List(Node), dicts : List(Node), override : Bool, replace : Bool, missing_ok : Bool }

	alter_ts_configuration_stmt_default : Node.AlterTSConfigurationStmt
	alter_ts_configuration_stmt_default = { kind: 0.I64, cfgname: [], tokentype: [], dicts: [], override: Bool.False, replace: Bool.False, missing_ok: Bool.False }

	alter_ts_configuration_stmt_of : Node -> Node.AlterTSConfigurationStmt
	alter_ts_configuration_stmt_of = |n|
		match n {
			AlterTSConfigurationStmt(r) => r
			_ => crash "expected AlterTSConfigurationStmt, got ${Node.tag(n)}"
		}

	## `AlterTSDictionaryStmt`
	AlterTSDictionaryStmt : { dictname : List(Node), options : List(Node) }

	alter_ts_dictionary_stmt_default : Node.AlterTSDictionaryStmt
	alter_ts_dictionary_stmt_default = { dictname: [], options: [] }

	alter_ts_dictionary_stmt_of : Node -> Node.AlterTSDictionaryStmt
	alter_ts_dictionary_stmt_of = |n|
		match n {
			AlterTSDictionaryStmt(r) => r
			_ => crash "expected AlterTSDictionaryStmt, got ${Node.tag(n)}"
		}

	## `AlterTableCmd`
	AlterTableCmd : { subtype : I64, name : Node.Text, num : I64, newowner : Node, def : Node, behavior : I64, missing_ok : Bool, recurse : Bool }

	alter_table_cmd_default : Node.AlterTableCmd
	alter_table_cmd_default = { subtype: 0.I64, name: Err(Null), num: 0.I64, newowner: Node.null, def: Node.null, behavior: 0.I64, missing_ok: Bool.False, recurse: Bool.False }

	alter_table_cmd_of : Node -> Node.AlterTableCmd
	alter_table_cmd_of = |n|
		match n {
			AlterTableCmd(r) => r
			_ => crash "expected AlterTableCmd, got ${Node.tag(n)}"
		}

	## `AlterTableMoveAllStmt`
	AlterTableMoveAllStmt : { orig_tablespacename : Node.Text, objtype : I64, roles : List(Node), new_tablespacename : Node.Text, nowait : Bool }

	alter_table_move_all_stmt_default : Node.AlterTableMoveAllStmt
	alter_table_move_all_stmt_default = { orig_tablespacename: Err(Null), objtype: 0.I64, roles: [], new_tablespacename: Err(Null), nowait: Bool.False }

	alter_table_move_all_stmt_of : Node -> Node.AlterTableMoveAllStmt
	alter_table_move_all_stmt_of = |n|
		match n {
			AlterTableMoveAllStmt(r) => r
			_ => crash "expected AlterTableMoveAllStmt, got ${Node.tag(n)}"
		}

	## `AlterTableSpaceOptionsStmt`
	AlterTableSpaceOptionsStmt : { tablespacename : Node.Text, options : List(Node), is_reset : Bool }

	alter_table_space_options_stmt_default : Node.AlterTableSpaceOptionsStmt
	alter_table_space_options_stmt_default = { tablespacename: Err(Null), options: [], is_reset: Bool.False }

	alter_table_space_options_stmt_of : Node -> Node.AlterTableSpaceOptionsStmt
	alter_table_space_options_stmt_of = |n|
		match n {
			AlterTableSpaceOptionsStmt(r) => r
			_ => crash "expected AlterTableSpaceOptionsStmt, got ${Node.tag(n)}"
		}

	## `AlterTableStmt`
	AlterTableStmt : { relation : Node, cmds : List(Node), objtype : I64, missing_ok : Bool }

	alter_table_stmt_default : Node.AlterTableStmt
	alter_table_stmt_default = { relation: Node.null, cmds: [], objtype: 0.I64, missing_ok: Bool.False }

	alter_table_stmt_of : Node -> Node.AlterTableStmt
	alter_table_stmt_of = |n|
		match n {
			AlterTableStmt(r) => r
			_ => crash "expected AlterTableStmt, got ${Node.tag(n)}"
		}

	## `AlterTypeStmt`
	AlterTypeStmt : { type_name : List(Node), options : List(Node) }

	alter_type_stmt_default : Node.AlterTypeStmt
	alter_type_stmt_default = { type_name: [], options: [] }

	alter_type_stmt_of : Node -> Node.AlterTypeStmt
	alter_type_stmt_of = |n|
		match n {
			AlterTypeStmt(r) => r
			_ => crash "expected AlterTypeStmt, got ${Node.tag(n)}"
		}

	## `AlterUserMappingStmt`
	AlterUserMappingStmt : { user : Node, servername : Node.Text, options : List(Node) }

	alter_user_mapping_stmt_default : Node.AlterUserMappingStmt
	alter_user_mapping_stmt_default = { user: Node.null, servername: Err(Null), options: [] }

	alter_user_mapping_stmt_of : Node -> Node.AlterUserMappingStmt
	alter_user_mapping_stmt_of = |n|
		match n {
			AlterUserMappingStmt(r) => r
			_ => crash "expected AlterUserMappingStmt, got ${Node.tag(n)}"
		}

	## `BitString`
	BitString : { bsval : Node.Text }

	bit_string_default : Node.BitString
	bit_string_default = { bsval: Err(Null) }

	bit_string_of : Node -> Node.BitString
	bit_string_of = |n|
		match n {
			BitString(r) => r
			_ => crash "expected BitString, got ${Node.tag(n)}"
		}

	## `BoolExpr`
	BoolExpr : { boolop : I64, args : List(Node), location : I64 }

	bool_expr_default : Node.BoolExpr
	bool_expr_default = { boolop: 0.I64, args: [], location: 0.I64 }

	bool_expr_of : Node -> Node.BoolExpr
	bool_expr_of = |n|
		match n {
			BoolExpr(r) => r
			_ => crash "expected BoolExpr, got ${Node.tag(n)}"
		}

	## `Boolean`
	Boolean : { boolval : Bool }

	boolean_default : Node.Boolean
	boolean_default = { boolval: Bool.False }

	boolean_of : Node -> Node.Boolean
	boolean_of = |n|
		match n {
			Boolean(r) => r
			_ => crash "expected Boolean, got ${Node.tag(n)}"
		}

	## `BooleanTest`
	BooleanTest : { arg : Node, booltesttype : I64, location : I64 }

	boolean_test_default : Node.BooleanTest
	boolean_test_default = { arg: Node.null, booltesttype: 0.I64, location: 0.I64 }

	boolean_test_of : Node -> Node.BooleanTest
	boolean_test_of = |n|
		match n {
			BooleanTest(r) => r
			_ => crash "expected BooleanTest, got ${Node.tag(n)}"
		}

	## `CTECycleClause`
	CTECycleClause : { cycle_col_list : List(Node), cycle_mark_column : Node.Text, cycle_mark_value : Node, cycle_mark_default : Node, cycle_path_column : Node.Text, location : I64, cycle_mark_type : I64, cycle_mark_typmod : I64, cycle_mark_collation : I64, cycle_mark_neop : I64 }

	cte_cycle_clause_default : Node.CTECycleClause
	cte_cycle_clause_default = { cycle_col_list: [], cycle_mark_column: Err(Null), cycle_mark_value: Node.null, cycle_mark_default: Node.null, cycle_path_column: Err(Null), location: 0.I64, cycle_mark_type: 0.I64, cycle_mark_typmod: 0.I64, cycle_mark_collation: 0.I64, cycle_mark_neop: 0.I64 }

	cte_cycle_clause_of : Node -> Node.CTECycleClause
	cte_cycle_clause_of = |n|
		match n {
			CTECycleClause(r) => r
			_ => crash "expected CTECycleClause, got ${Node.tag(n)}"
		}

	## `CTESearchClause`
	CTESearchClause : { search_col_list : List(Node), search_breadth_first : Bool, search_seq_column : Node.Text, location : I64 }

	cte_search_clause_default : Node.CTESearchClause
	cte_search_clause_default = { search_col_list: [], search_breadth_first: Bool.False, search_seq_column: Err(Null), location: 0.I64 }

	cte_search_clause_of : Node -> Node.CTESearchClause
	cte_search_clause_of = |n|
		match n {
			CTESearchClause(r) => r
			_ => crash "expected CTESearchClause, got ${Node.tag(n)}"
		}

	## `CallStmt`
	CallStmt : { funccall : Node, funcexpr : Node, outargs : List(Node) }

	call_stmt_default : Node.CallStmt
	call_stmt_default = { funccall: Node.null, funcexpr: Node.null, outargs: [] }

	call_stmt_of : Node -> Node.CallStmt
	call_stmt_of = |n|
		match n {
			CallStmt(r) => r
			_ => crash "expected CallStmt, got ${Node.tag(n)}"
		}

	## `CaseExpr`
	CaseExpr : { casetype : I64, casecollid : I64, arg : Node, args : List(Node), defresult : Node, location : I64 }

	case_expr_default : Node.CaseExpr
	case_expr_default = { casetype: 0.I64, casecollid: 0.I64, arg: Node.null, args: [], defresult: Node.null, location: 0.I64 }

	case_expr_of : Node -> Node.CaseExpr
	case_expr_of = |n|
		match n {
			CaseExpr(r) => r
			_ => crash "expected CaseExpr, got ${Node.tag(n)}"
		}

	## `CaseWhen`
	CaseWhen : { expr : Node, result : Node, location : I64 }

	case_when_default : Node.CaseWhen
	case_when_default = { expr: Node.null, result: Node.null, location: 0.I64 }

	case_when_of : Node -> Node.CaseWhen
	case_when_of = |n|
		match n {
			CaseWhen(r) => r
			_ => crash "expected CaseWhen, got ${Node.tag(n)}"
		}

	## `CheckPointStmt`
	CheckPointStmt : {}

	check_point_stmt_default : Node.CheckPointStmt
	check_point_stmt_default = {}

	check_point_stmt_of : Node -> Node.CheckPointStmt
	check_point_stmt_of = |n|
		match n {
			CheckPointStmt(r) => r
			_ => crash "expected CheckPointStmt, got ${Node.tag(n)}"
		}

	## `ClosePortalStmt`
	ClosePortalStmt : { portalname : Node.Text }

	close_portal_stmt_default : Node.ClosePortalStmt
	close_portal_stmt_default = { portalname: Err(Null) }

	close_portal_stmt_of : Node -> Node.ClosePortalStmt
	close_portal_stmt_of = |n|
		match n {
			ClosePortalStmt(r) => r
			_ => crash "expected ClosePortalStmt, got ${Node.tag(n)}"
		}

	## `ClusterStmt`
	ClusterStmt : { relation : Node, indexname : Node.Text, params : List(Node) }

	cluster_stmt_default : Node.ClusterStmt
	cluster_stmt_default = { relation: Node.null, indexname: Err(Null), params: [] }

	cluster_stmt_of : Node -> Node.ClusterStmt
	cluster_stmt_of = |n|
		match n {
			ClusterStmt(r) => r
			_ => crash "expected ClusterStmt, got ${Node.tag(n)}"
		}

	## `CoalesceExpr`
	CoalesceExpr : { coalescetype : I64, coalescecollid : I64, args : List(Node), location : I64 }

	coalesce_expr_default : Node.CoalesceExpr
	coalesce_expr_default = { coalescetype: 0.I64, coalescecollid: 0.I64, args: [], location: 0.I64 }

	coalesce_expr_of : Node -> Node.CoalesceExpr
	coalesce_expr_of = |n|
		match n {
			CoalesceExpr(r) => r
			_ => crash "expected CoalesceExpr, got ${Node.tag(n)}"
		}

	## `CollateClause`
	CollateClause : { arg : Node, collname : List(Node), location : I64 }

	collate_clause_default : Node.CollateClause
	collate_clause_default = { arg: Node.null, collname: [], location: 0.I64 }

	collate_clause_of : Node -> Node.CollateClause
	collate_clause_of = |n|
		match n {
			CollateClause(r) => r
			_ => crash "expected CollateClause, got ${Node.tag(n)}"
		}

	## `ColumnDef`
	ColumnDef : { colname : Node.Text, type_name : Node, compression : Node.Text, inhcount : I64, is_local : Bool, is_not_null : Bool, is_from_type : Bool, storage : I64, storage_name : Node.Text, raw_default : Node, cooked_default : Node, identity : I64, identity_sequence : Node, generated : I64, coll_clause : Node, coll_oid : I64, constraints : List(Node), fdwoptions : List(Node), location : I64 }

	column_def_default : Node.ColumnDef
	column_def_default = { colname: Err(Null), type_name: Node.null, compression: Err(Null), inhcount: 0.I64, is_local: Bool.False, is_not_null: Bool.False, is_from_type: Bool.False, storage: 0.I64, storage_name: Err(Null), raw_default: Node.null, cooked_default: Node.null, identity: 0.I64, identity_sequence: Node.null, generated: 0.I64, coll_clause: Node.null, coll_oid: 0.I64, constraints: [], fdwoptions: [], location: 0.I64 }

	column_def_of : Node -> Node.ColumnDef
	column_def_of = |n|
		match n {
			ColumnDef(r) => r
			_ => crash "expected ColumnDef, got ${Node.tag(n)}"
		}

	## `ColumnRef`
	ColumnRef : { fields : List(Node), location : I64 }

	column_ref_default : Node.ColumnRef
	column_ref_default = { fields: [], location: 0.I64 }

	column_ref_of : Node -> Node.ColumnRef
	column_ref_of = |n|
		match n {
			ColumnRef(r) => r
			_ => crash "expected ColumnRef, got ${Node.tag(n)}"
		}

	## `CommentStmt`
	CommentStmt : { objtype : I64, object : Node, comment : Node.Text }

	comment_stmt_default : Node.CommentStmt
	comment_stmt_default = { objtype: 0.I64, object: Node.null, comment: Err(Null) }

	comment_stmt_of : Node -> Node.CommentStmt
	comment_stmt_of = |n|
		match n {
			CommentStmt(r) => r
			_ => crash "expected CommentStmt, got ${Node.tag(n)}"
		}

	## `CommonTableExpr`
	CommonTableExpr : { ctename : Node.Text, aliascolnames : List(Node), ctematerialized : I64, ctequery : Node, search_clause : Node, cycle_clause : Node, location : I64, cterecursive : Bool, cterefcount : I64, ctecolnames : List(Node), ctecoltypes : List(Node), ctecoltypmods : List(Node), ctecolcollations : List(Node) }

	common_table_expr_default : Node.CommonTableExpr
	common_table_expr_default = { ctename: Err(Null), aliascolnames: [], ctematerialized: 0.I64, ctequery: Node.null, search_clause: Node.null, cycle_clause: Node.null, location: 0.I64, cterecursive: Bool.False, cterefcount: 0.I64, ctecolnames: [], ctecoltypes: [], ctecoltypmods: [], ctecolcollations: [] }

	common_table_expr_of : Node -> Node.CommonTableExpr
	common_table_expr_of = |n|
		match n {
			CommonTableExpr(r) => r
			_ => crash "expected CommonTableExpr, got ${Node.tag(n)}"
		}

	## `CompositeTypeStmt`
	CompositeTypeStmt : { typevar : Node, coldeflist : List(Node) }

	composite_type_stmt_default : Node.CompositeTypeStmt
	composite_type_stmt_default = { typevar: Node.null, coldeflist: [] }

	composite_type_stmt_of : Node -> Node.CompositeTypeStmt
	composite_type_stmt_of = |n|
		match n {
			CompositeTypeStmt(r) => r
			_ => crash "expected CompositeTypeStmt, got ${Node.tag(n)}"
		}

	## `Constraint`
	Constraint : { contype : I64, conname : Node.Text, deferrable : Bool, initdeferred : Bool, is_enforced : Bool, skip_validation : Bool, initially_valid : Bool, is_no_inherit : Bool, raw_expr : Node, cooked_expr : Node.Text, generated_when : I64, generated_kind : I64, nulls_not_distinct : Bool, keys : List(Node), without_overlaps : Bool, including : List(Node), exclusions : List(Node), options : List(Node), indexname : Node.Text, indexspace : Node.Text, reset_default_tblspc : Bool, access_method : Node.Text, where_clause : Node, pktable : Node, fk_attrs : List(Node), pk_attrs : List(Node), fk_with_period : Bool, pk_with_period : Bool, fk_matchtype : I64, fk_upd_action : I64, fk_del_action : I64, fk_del_set_cols : List(Node), old_conpfeqop : List(Node), old_pktable_oid : I64, location : I64 }

	constraint_default : Node.Constraint
	constraint_default = { contype: 0.I64, conname: Err(Null), deferrable: Bool.False, initdeferred: Bool.False, is_enforced: Bool.False, skip_validation: Bool.False, initially_valid: Bool.False, is_no_inherit: Bool.False, raw_expr: Node.null, cooked_expr: Err(Null), generated_when: 0.I64, generated_kind: 0.I64, nulls_not_distinct: Bool.False, keys: [], without_overlaps: Bool.False, including: [], exclusions: [], options: [], indexname: Err(Null), indexspace: Err(Null), reset_default_tblspc: Bool.False, access_method: Err(Null), where_clause: Node.null, pktable: Node.null, fk_attrs: [], pk_attrs: [], fk_with_period: Bool.False, pk_with_period: Bool.False, fk_matchtype: 0.I64, fk_upd_action: 0.I64, fk_del_action: 0.I64, fk_del_set_cols: [], old_conpfeqop: [], old_pktable_oid: 0.I64, location: 0.I64 }

	constraint_of : Node -> Node.Constraint
	constraint_of = |n|
		match n {
			Constraint(r) => r
			_ => crash "expected Constraint, got ${Node.tag(n)}"
		}

	## `ConstraintsSetStmt`
	ConstraintsSetStmt : { constraints : List(Node), deferred : Bool }

	constraints_set_stmt_default : Node.ConstraintsSetStmt
	constraints_set_stmt_default = { constraints: [], deferred: Bool.False }

	constraints_set_stmt_of : Node -> Node.ConstraintsSetStmt
	constraints_set_stmt_of = |n|
		match n {
			ConstraintsSetStmt(r) => r
			_ => crash "expected ConstraintsSetStmt, got ${Node.tag(n)}"
		}

	## `CopyStmt`
	CopyStmt : { relation : Node, query : Node, attlist : List(Node), is_from : Bool, is_program : Bool, filename : Node.Text, options : List(Node), where_clause : Node }

	copy_stmt_default : Node.CopyStmt
	copy_stmt_default = { relation: Node.null, query: Node.null, attlist: [], is_from: Bool.False, is_program: Bool.False, filename: Err(Null), options: [], where_clause: Node.null }

	copy_stmt_of : Node -> Node.CopyStmt
	copy_stmt_of = |n|
		match n {
			CopyStmt(r) => r
			_ => crash "expected CopyStmt, got ${Node.tag(n)}"
		}

	## `CreateAmStmt`
	CreateAmStmt : { amname : Node.Text, handler_name : List(Node), amtype : I64 }

	create_am_stmt_default : Node.CreateAmStmt
	create_am_stmt_default = { amname: Err(Null), handler_name: [], amtype: 0.I64 }

	create_am_stmt_of : Node -> Node.CreateAmStmt
	create_am_stmt_of = |n|
		match n {
			CreateAmStmt(r) => r
			_ => crash "expected CreateAmStmt, got ${Node.tag(n)}"
		}

	## `CreateCastStmt`
	CreateCastStmt : { sourcetype : Node, targettype : Node, func : Node, context : I64, inout : Bool }

	create_cast_stmt_default : Node.CreateCastStmt
	create_cast_stmt_default = { sourcetype: Node.null, targettype: Node.null, func: Node.null, context: 0.I64, inout: Bool.False }

	create_cast_stmt_of : Node -> Node.CreateCastStmt
	create_cast_stmt_of = |n|
		match n {
			CreateCastStmt(r) => r
			_ => crash "expected CreateCastStmt, got ${Node.tag(n)}"
		}

	## `CreateConversionStmt`
	CreateConversionStmt : { conversion_name : List(Node), for_encoding_name : Node.Text, to_encoding_name : Node.Text, func_name : List(Node), def : Bool }

	create_conversion_stmt_default : Node.CreateConversionStmt
	create_conversion_stmt_default = { conversion_name: [], for_encoding_name: Err(Null), to_encoding_name: Err(Null), func_name: [], def: Bool.False }

	create_conversion_stmt_of : Node -> Node.CreateConversionStmt
	create_conversion_stmt_of = |n|
		match n {
			CreateConversionStmt(r) => r
			_ => crash "expected CreateConversionStmt, got ${Node.tag(n)}"
		}

	## `CreateDomainStmt`
	CreateDomainStmt : { domainname : List(Node), type_name : Node, coll_clause : Node, constraints : List(Node) }

	create_domain_stmt_default : Node.CreateDomainStmt
	create_domain_stmt_default = { domainname: [], type_name: Node.null, coll_clause: Node.null, constraints: [] }

	create_domain_stmt_of : Node -> Node.CreateDomainStmt
	create_domain_stmt_of = |n|
		match n {
			CreateDomainStmt(r) => r
			_ => crash "expected CreateDomainStmt, got ${Node.tag(n)}"
		}

	## `CreateEnumStmt`
	CreateEnumStmt : { type_name : List(Node), vals : List(Node) }

	create_enum_stmt_default : Node.CreateEnumStmt
	create_enum_stmt_default = { type_name: [], vals: [] }

	create_enum_stmt_of : Node -> Node.CreateEnumStmt
	create_enum_stmt_of = |n|
		match n {
			CreateEnumStmt(r) => r
			_ => crash "expected CreateEnumStmt, got ${Node.tag(n)}"
		}

	## `CreateEventTrigStmt`
	CreateEventTrigStmt : { trigname : Node.Text, eventname : Node.Text, whenclause : List(Node), funcname : List(Node) }

	create_event_trig_stmt_default : Node.CreateEventTrigStmt
	create_event_trig_stmt_default = { trigname: Err(Null), eventname: Err(Null), whenclause: [], funcname: [] }

	create_event_trig_stmt_of : Node -> Node.CreateEventTrigStmt
	create_event_trig_stmt_of = |n|
		match n {
			CreateEventTrigStmt(r) => r
			_ => crash "expected CreateEventTrigStmt, got ${Node.tag(n)}"
		}

	## `CreateExtensionStmt`
	CreateExtensionStmt : { extname : Node.Text, if_not_exists : Bool, options : List(Node) }

	create_extension_stmt_default : Node.CreateExtensionStmt
	create_extension_stmt_default = { extname: Err(Null), if_not_exists: Bool.False, options: [] }

	create_extension_stmt_of : Node -> Node.CreateExtensionStmt
	create_extension_stmt_of = |n|
		match n {
			CreateExtensionStmt(r) => r
			_ => crash "expected CreateExtensionStmt, got ${Node.tag(n)}"
		}

	## `CreateFdwStmt`
	CreateFdwStmt : { fdwname : Node.Text, func_options : List(Node), options : List(Node) }

	create_fdw_stmt_default : Node.CreateFdwStmt
	create_fdw_stmt_default = { fdwname: Err(Null), func_options: [], options: [] }

	create_fdw_stmt_of : Node -> Node.CreateFdwStmt
	create_fdw_stmt_of = |n|
		match n {
			CreateFdwStmt(r) => r
			_ => crash "expected CreateFdwStmt, got ${Node.tag(n)}"
		}

	## `CreateForeignServerStmt`
	CreateForeignServerStmt : { servername : Node.Text, servertype : Node.Text, version : Node.Text, fdwname : Node.Text, if_not_exists : Bool, options : List(Node) }

	create_foreign_server_stmt_default : Node.CreateForeignServerStmt
	create_foreign_server_stmt_default = { servername: Err(Null), servertype: Err(Null), version: Err(Null), fdwname: Err(Null), if_not_exists: Bool.False, options: [] }

	create_foreign_server_stmt_of : Node -> Node.CreateForeignServerStmt
	create_foreign_server_stmt_of = |n|
		match n {
			CreateForeignServerStmt(r) => r
			_ => crash "expected CreateForeignServerStmt, got ${Node.tag(n)}"
		}

	## `CreateForeignTableStmt`
	CreateForeignTableStmt : { base : Node, servername : Node.Text, options : List(Node) }

	create_foreign_table_stmt_default : Node.CreateForeignTableStmt
	create_foreign_table_stmt_default = { base: Node.CreateStmt(Node.create_stmt_default), servername: Err(Null), options: [] }

	create_foreign_table_stmt_of : Node -> Node.CreateForeignTableStmt
	create_foreign_table_stmt_of = |n|
		match n {
			CreateForeignTableStmt(r) => r
			_ => crash "expected CreateForeignTableStmt, got ${Node.tag(n)}"
		}

	## `CreateFunctionStmt`
	CreateFunctionStmt : { is_procedure : Bool, replace : Bool, funcname : List(Node), parameters : List(Node), return_type : Node, options : List(Node), sql_body : Node }

	create_function_stmt_default : Node.CreateFunctionStmt
	create_function_stmt_default = { is_procedure: Bool.False, replace: Bool.False, funcname: [], parameters: [], return_type: Node.null, options: [], sql_body: Node.null }

	create_function_stmt_of : Node -> Node.CreateFunctionStmt
	create_function_stmt_of = |n|
		match n {
			CreateFunctionStmt(r) => r
			_ => crash "expected CreateFunctionStmt, got ${Node.tag(n)}"
		}

	## `CreateOpClassItem`
	CreateOpClassItem : { itemtype : I64, name : Node, number : I64, order_family : List(Node), class_args : List(Node), storedtype : Node }

	create_op_class_item_default : Node.CreateOpClassItem
	create_op_class_item_default = { itemtype: 0.I64, name: Node.null, number: 0.I64, order_family: [], class_args: [], storedtype: Node.null }

	create_op_class_item_of : Node -> Node.CreateOpClassItem
	create_op_class_item_of = |n|
		match n {
			CreateOpClassItem(r) => r
			_ => crash "expected CreateOpClassItem, got ${Node.tag(n)}"
		}

	## `CreateOpClassStmt`
	CreateOpClassStmt : { opclassname : List(Node), opfamilyname : List(Node), amname : Node.Text, datatype : Node, items : List(Node), is_default : Bool }

	create_op_class_stmt_default : Node.CreateOpClassStmt
	create_op_class_stmt_default = { opclassname: [], opfamilyname: [], amname: Err(Null), datatype: Node.null, items: [], is_default: Bool.False }

	create_op_class_stmt_of : Node -> Node.CreateOpClassStmt
	create_op_class_stmt_of = |n|
		match n {
			CreateOpClassStmt(r) => r
			_ => crash "expected CreateOpClassStmt, got ${Node.tag(n)}"
		}

	## `CreateOpFamilyStmt`
	CreateOpFamilyStmt : { opfamilyname : List(Node), amname : Node.Text }

	create_op_family_stmt_default : Node.CreateOpFamilyStmt
	create_op_family_stmt_default = { opfamilyname: [], amname: Err(Null) }

	create_op_family_stmt_of : Node -> Node.CreateOpFamilyStmt
	create_op_family_stmt_of = |n|
		match n {
			CreateOpFamilyStmt(r) => r
			_ => crash "expected CreateOpFamilyStmt, got ${Node.tag(n)}"
		}

	## `CreatePLangStmt`
	CreatePLangStmt : { replace : Bool, plname : Node.Text, plhandler : List(Node), plinline : List(Node), plvalidator : List(Node), pltrusted : Bool }

	create_p_lang_stmt_default : Node.CreatePLangStmt
	create_p_lang_stmt_default = { replace: Bool.False, plname: Err(Null), plhandler: [], plinline: [], plvalidator: [], pltrusted: Bool.False }

	create_p_lang_stmt_of : Node -> Node.CreatePLangStmt
	create_p_lang_stmt_of = |n|
		match n {
			CreatePLangStmt(r) => r
			_ => crash "expected CreatePLangStmt, got ${Node.tag(n)}"
		}

	## `CreatePolicyStmt`
	CreatePolicyStmt : { policy_name : Node.Text, table : Node, cmd_name : Node.Text, permissive : Bool, roles : List(Node), qual : Node, with_check : Node }

	create_policy_stmt_default : Node.CreatePolicyStmt
	create_policy_stmt_default = { policy_name: Err(Null), table: Node.null, cmd_name: Err(Null), permissive: Bool.False, roles: [], qual: Node.null, with_check: Node.null }

	create_policy_stmt_of : Node -> Node.CreatePolicyStmt
	create_policy_stmt_of = |n|
		match n {
			CreatePolicyStmt(r) => r
			_ => crash "expected CreatePolicyStmt, got ${Node.tag(n)}"
		}

	## `CreatePublicationStmt`
	CreatePublicationStmt : { pubname : Node.Text, options : List(Node), pubobjects : List(Node), for_all_tables : Bool }

	create_publication_stmt_default : Node.CreatePublicationStmt
	create_publication_stmt_default = { pubname: Err(Null), options: [], pubobjects: [], for_all_tables: Bool.False }

	create_publication_stmt_of : Node -> Node.CreatePublicationStmt
	create_publication_stmt_of = |n|
		match n {
			CreatePublicationStmt(r) => r
			_ => crash "expected CreatePublicationStmt, got ${Node.tag(n)}"
		}

	## `CreateRangeStmt`
	CreateRangeStmt : { type_name : List(Node), params : List(Node) }

	create_range_stmt_default : Node.CreateRangeStmt
	create_range_stmt_default = { type_name: [], params: [] }

	create_range_stmt_of : Node -> Node.CreateRangeStmt
	create_range_stmt_of = |n|
		match n {
			CreateRangeStmt(r) => r
			_ => crash "expected CreateRangeStmt, got ${Node.tag(n)}"
		}

	## `CreateRoleStmt`
	CreateRoleStmt : { stmt_type : I64, role : Node.Text, options : List(Node) }

	create_role_stmt_default : Node.CreateRoleStmt
	create_role_stmt_default = { stmt_type: 0.I64, role: Err(Null), options: [] }

	create_role_stmt_of : Node -> Node.CreateRoleStmt
	create_role_stmt_of = |n|
		match n {
			CreateRoleStmt(r) => r
			_ => crash "expected CreateRoleStmt, got ${Node.tag(n)}"
		}

	## `CreateSchemaStmt`
	CreateSchemaStmt : { schemaname : Node.Text, authrole : Node, schema_elts : List(Node), if_not_exists : Bool }

	create_schema_stmt_default : Node.CreateSchemaStmt
	create_schema_stmt_default = { schemaname: Err(Null), authrole: Node.null, schema_elts: [], if_not_exists: Bool.False }

	create_schema_stmt_of : Node -> Node.CreateSchemaStmt
	create_schema_stmt_of = |n|
		match n {
			CreateSchemaStmt(r) => r
			_ => crash "expected CreateSchemaStmt, got ${Node.tag(n)}"
		}

	## `CreateSeqStmt`
	CreateSeqStmt : { sequence : Node, options : List(Node), owner_id : I64, for_identity : Bool, if_not_exists : Bool }

	create_seq_stmt_default : Node.CreateSeqStmt
	create_seq_stmt_default = { sequence: Node.null, options: [], owner_id: 0.I64, for_identity: Bool.False, if_not_exists: Bool.False }

	create_seq_stmt_of : Node -> Node.CreateSeqStmt
	create_seq_stmt_of = |n|
		match n {
			CreateSeqStmt(r) => r
			_ => crash "expected CreateSeqStmt, got ${Node.tag(n)}"
		}

	## `CreateStatsStmt`
	CreateStatsStmt : { defnames : List(Node), stat_types : List(Node), exprs : List(Node), relations : List(Node), stxcomment : Node.Text, transformed : Bool, if_not_exists : Bool, owner : I64 }

	create_stats_stmt_default : Node.CreateStatsStmt
	create_stats_stmt_default = { defnames: [], stat_types: [], exprs: [], relations: [], stxcomment: Err(Null), transformed: Bool.False, if_not_exists: Bool.False, owner: 0.I64 }

	create_stats_stmt_of : Node -> Node.CreateStatsStmt
	create_stats_stmt_of = |n|
		match n {
			CreateStatsStmt(r) => r
			_ => crash "expected CreateStatsStmt, got ${Node.tag(n)}"
		}

	## `CreateStmt`
	CreateStmt : { relation : Node, table_elts : List(Node), inh_relations : List(Node), partbound : Node, partspec : Node, of_typename : Node, constraints : List(Node), nnconstraints : List(Node), options : List(Node), oncommit : I64, tablespacename : Node.Text, access_method : Node.Text, if_not_exists : Bool }

	create_stmt_default : Node.CreateStmt
	create_stmt_default = { relation: Node.null, table_elts: [], inh_relations: [], partbound: Node.null, partspec: Node.null, of_typename: Node.null, constraints: [], nnconstraints: [], options: [], oncommit: 0.I64, tablespacename: Err(Null), access_method: Err(Null), if_not_exists: Bool.False }

	create_stmt_of : Node -> Node.CreateStmt
	create_stmt_of = |n|
		match n {
			CreateStmt(r) => r
			_ => crash "expected CreateStmt, got ${Node.tag(n)}"
		}

	## `CreateSubscriptionStmt`
	CreateSubscriptionStmt : { subname : Node.Text, conninfo : Node.Text, publication : List(Node), options : List(Node) }

	create_subscription_stmt_default : Node.CreateSubscriptionStmt
	create_subscription_stmt_default = { subname: Err(Null), conninfo: Err(Null), publication: [], options: [] }

	create_subscription_stmt_of : Node -> Node.CreateSubscriptionStmt
	create_subscription_stmt_of = |n|
		match n {
			CreateSubscriptionStmt(r) => r
			_ => crash "expected CreateSubscriptionStmt, got ${Node.tag(n)}"
		}

	## `CreateTableAsStmt`
	CreateTableAsStmt : { query : Node, into : Node, objtype : I64, is_select_into : Bool, if_not_exists : Bool }

	create_table_as_stmt_default : Node.CreateTableAsStmt
	create_table_as_stmt_default = { query: Node.null, into: Node.null, objtype: 0.I64, is_select_into: Bool.False, if_not_exists: Bool.False }

	create_table_as_stmt_of : Node -> Node.CreateTableAsStmt
	create_table_as_stmt_of = |n|
		match n {
			CreateTableAsStmt(r) => r
			_ => crash "expected CreateTableAsStmt, got ${Node.tag(n)}"
		}

	## `CreateTableSpaceStmt`
	CreateTableSpaceStmt : { tablespacename : Node.Text, owner : Node, location : Node.Text, options : List(Node) }

	create_table_space_stmt_default : Node.CreateTableSpaceStmt
	create_table_space_stmt_default = { tablespacename: Err(Null), owner: Node.null, location: Err(Null), options: [] }

	create_table_space_stmt_of : Node -> Node.CreateTableSpaceStmt
	create_table_space_stmt_of = |n|
		match n {
			CreateTableSpaceStmt(r) => r
			_ => crash "expected CreateTableSpaceStmt, got ${Node.tag(n)}"
		}

	## `CreateTransformStmt`
	CreateTransformStmt : { replace : Bool, type_name : Node, lang : Node.Text, fromsql : Node, tosql : Node }

	create_transform_stmt_default : Node.CreateTransformStmt
	create_transform_stmt_default = { replace: Bool.False, type_name: Node.null, lang: Err(Null), fromsql: Node.null, tosql: Node.null }

	create_transform_stmt_of : Node -> Node.CreateTransformStmt
	create_transform_stmt_of = |n|
		match n {
			CreateTransformStmt(r) => r
			_ => crash "expected CreateTransformStmt, got ${Node.tag(n)}"
		}

	## `CreateTrigStmt`
	CreateTrigStmt : { replace : Bool, isconstraint : Bool, trigname : Node.Text, relation : Node, funcname : List(Node), args : List(Node), row : Bool, timing : I64, events : I64, columns : List(Node), when_clause : Node, transition_rels : List(Node), deferrable : Bool, initdeferred : Bool, constrrel : Node }

	create_trig_stmt_default : Node.CreateTrigStmt
	create_trig_stmt_default = { replace: Bool.False, isconstraint: Bool.False, trigname: Err(Null), relation: Node.null, funcname: [], args: [], row: Bool.False, timing: 0.I64, events: 0.I64, columns: [], when_clause: Node.null, transition_rels: [], deferrable: Bool.False, initdeferred: Bool.False, constrrel: Node.null }

	create_trig_stmt_of : Node -> Node.CreateTrigStmt
	create_trig_stmt_of = |n|
		match n {
			CreateTrigStmt(r) => r
			_ => crash "expected CreateTrigStmt, got ${Node.tag(n)}"
		}

	## `CreateUserMappingStmt`
	CreateUserMappingStmt : { user : Node, servername : Node.Text, if_not_exists : Bool, options : List(Node) }

	create_user_mapping_stmt_default : Node.CreateUserMappingStmt
	create_user_mapping_stmt_default = { user: Node.null, servername: Err(Null), if_not_exists: Bool.False, options: [] }

	create_user_mapping_stmt_of : Node -> Node.CreateUserMappingStmt
	create_user_mapping_stmt_of = |n|
		match n {
			CreateUserMappingStmt(r) => r
			_ => crash "expected CreateUserMappingStmt, got ${Node.tag(n)}"
		}

	## `CreatedbStmt`
	CreatedbStmt : { dbname : Node.Text, options : List(Node) }

	createdb_stmt_default : Node.CreatedbStmt
	createdb_stmt_default = { dbname: Err(Null), options: [] }

	createdb_stmt_of : Node -> Node.CreatedbStmt
	createdb_stmt_of = |n|
		match n {
			CreatedbStmt(r) => r
			_ => crash "expected CreatedbStmt, got ${Node.tag(n)}"
		}

	## `CurrentOfExpr`
	CurrentOfExpr : { cvarno : I64, cursor_name : Node.Text, cursor_param : I64 }

	current_of_expr_default : Node.CurrentOfExpr
	current_of_expr_default = { cvarno: 0.I64, cursor_name: Err(Null), cursor_param: 0.I64 }

	current_of_expr_of : Node -> Node.CurrentOfExpr
	current_of_expr_of = |n|
		match n {
			CurrentOfExpr(r) => r
			_ => crash "expected CurrentOfExpr, got ${Node.tag(n)}"
		}

	## `DeallocateStmt`
	DeallocateStmt : { name : Node.Text, isall : Bool, location : I64 }

	deallocate_stmt_default : Node.DeallocateStmt
	deallocate_stmt_default = { name: Err(Null), isall: Bool.False, location: 0.I64 }

	deallocate_stmt_of : Node -> Node.DeallocateStmt
	deallocate_stmt_of = |n|
		match n {
			DeallocateStmt(r) => r
			_ => crash "expected DeallocateStmt, got ${Node.tag(n)}"
		}

	## `DeclareCursorStmt`
	DeclareCursorStmt : { portalname : Node.Text, options : I64, query : Node }

	declare_cursor_stmt_default : Node.DeclareCursorStmt
	declare_cursor_stmt_default = { portalname: Err(Null), options: 0.I64, query: Node.null }

	declare_cursor_stmt_of : Node -> Node.DeclareCursorStmt
	declare_cursor_stmt_of = |n|
		match n {
			DeclareCursorStmt(r) => r
			_ => crash "expected DeclareCursorStmt, got ${Node.tag(n)}"
		}

	## `DefElem`
	DefElem : { defnamespace : Node.Text, defname : Node.Text, arg : Node, defaction : I64, location : I64 }

	def_elem_default : Node.DefElem
	def_elem_default = { defnamespace: Err(Null), defname: Err(Null), arg: Node.null, defaction: 0.I64, location: 0.I64 }

	def_elem_of : Node -> Node.DefElem
	def_elem_of = |n|
		match n {
			DefElem(r) => r
			_ => crash "expected DefElem, got ${Node.tag(n)}"
		}

	## `DefineStmt`
	DefineStmt : { kind : I64, oldstyle : Bool, defnames : List(Node), args : List(Node), definition : List(Node), if_not_exists : Bool, replace : Bool }

	define_stmt_default : Node.DefineStmt
	define_stmt_default = { kind: 0.I64, oldstyle: Bool.False, defnames: [], args: [], definition: [], if_not_exists: Bool.False, replace: Bool.False }

	define_stmt_of : Node -> Node.DefineStmt
	define_stmt_of = |n|
		match n {
			DefineStmt(r) => r
			_ => crash "expected DefineStmt, got ${Node.tag(n)}"
		}

	## `DeleteStmt`
	DeleteStmt : { relation : Node, using_clause : List(Node), where_clause : Node, returning_clause : Node, with_clause : Node }

	delete_stmt_default : Node.DeleteStmt
	delete_stmt_default = { relation: Node.null, using_clause: [], where_clause: Node.null, returning_clause: Node.null, with_clause: Node.null }

	delete_stmt_of : Node -> Node.DeleteStmt
	delete_stmt_of = |n|
		match n {
			DeleteStmt(r) => r
			_ => crash "expected DeleteStmt, got ${Node.tag(n)}"
		}

	## `DiscardStmt`
	DiscardStmt : { target : I64 }

	discard_stmt_default : Node.DiscardStmt
	discard_stmt_default = { target: 0.I64 }

	discard_stmt_of : Node -> Node.DiscardStmt
	discard_stmt_of = |n|
		match n {
			DiscardStmt(r) => r
			_ => crash "expected DiscardStmt, got ${Node.tag(n)}"
		}

	## `DoStmt`
	DoStmt : { args : List(Node) }

	do_stmt_default : Node.DoStmt
	do_stmt_default = { args: [] }

	do_stmt_of : Node -> Node.DoStmt
	do_stmt_of = |n|
		match n {
			DoStmt(r) => r
			_ => crash "expected DoStmt, got ${Node.tag(n)}"
		}

	## `DropOwnedStmt`
	DropOwnedStmt : { roles : List(Node), behavior : I64 }

	drop_owned_stmt_default : Node.DropOwnedStmt
	drop_owned_stmt_default = { roles: [], behavior: 0.I64 }

	drop_owned_stmt_of : Node -> Node.DropOwnedStmt
	drop_owned_stmt_of = |n|
		match n {
			DropOwnedStmt(r) => r
			_ => crash "expected DropOwnedStmt, got ${Node.tag(n)}"
		}

	## `DropRoleStmt`
	DropRoleStmt : { roles : List(Node), missing_ok : Bool }

	drop_role_stmt_default : Node.DropRoleStmt
	drop_role_stmt_default = { roles: [], missing_ok: Bool.False }

	drop_role_stmt_of : Node -> Node.DropRoleStmt
	drop_role_stmt_of = |n|
		match n {
			DropRoleStmt(r) => r
			_ => crash "expected DropRoleStmt, got ${Node.tag(n)}"
		}

	## `DropStmt`
	DropStmt : { objects : List(Node), remove_type : I64, behavior : I64, missing_ok : Bool, concurrent : Bool }

	drop_stmt_default : Node.DropStmt
	drop_stmt_default = { objects: [], remove_type: 0.I64, behavior: 0.I64, missing_ok: Bool.False, concurrent: Bool.False }

	drop_stmt_of : Node -> Node.DropStmt
	drop_stmt_of = |n|
		match n {
			DropStmt(r) => r
			_ => crash "expected DropStmt, got ${Node.tag(n)}"
		}

	## `DropSubscriptionStmt`
	DropSubscriptionStmt : { subname : Node.Text, missing_ok : Bool, behavior : I64 }

	drop_subscription_stmt_default : Node.DropSubscriptionStmt
	drop_subscription_stmt_default = { subname: Err(Null), missing_ok: Bool.False, behavior: 0.I64 }

	drop_subscription_stmt_of : Node -> Node.DropSubscriptionStmt
	drop_subscription_stmt_of = |n|
		match n {
			DropSubscriptionStmt(r) => r
			_ => crash "expected DropSubscriptionStmt, got ${Node.tag(n)}"
		}

	## `DropTableSpaceStmt`
	DropTableSpaceStmt : { tablespacename : Node.Text, missing_ok : Bool }

	drop_table_space_stmt_default : Node.DropTableSpaceStmt
	drop_table_space_stmt_default = { tablespacename: Err(Null), missing_ok: Bool.False }

	drop_table_space_stmt_of : Node -> Node.DropTableSpaceStmt
	drop_table_space_stmt_of = |n|
		match n {
			DropTableSpaceStmt(r) => r
			_ => crash "expected DropTableSpaceStmt, got ${Node.tag(n)}"
		}

	## `DropUserMappingStmt`
	DropUserMappingStmt : { user : Node, servername : Node.Text, missing_ok : Bool }

	drop_user_mapping_stmt_default : Node.DropUserMappingStmt
	drop_user_mapping_stmt_default = { user: Node.null, servername: Err(Null), missing_ok: Bool.False }

	drop_user_mapping_stmt_of : Node -> Node.DropUserMappingStmt
	drop_user_mapping_stmt_of = |n|
		match n {
			DropUserMappingStmt(r) => r
			_ => crash "expected DropUserMappingStmt, got ${Node.tag(n)}"
		}

	## `DropdbStmt`
	DropdbStmt : { dbname : Node.Text, missing_ok : Bool, options : List(Node) }

	dropdb_stmt_default : Node.DropdbStmt
	dropdb_stmt_default = { dbname: Err(Null), missing_ok: Bool.False, options: [] }

	dropdb_stmt_of : Node -> Node.DropdbStmt
	dropdb_stmt_of = |n|
		match n {
			DropdbStmt(r) => r
			_ => crash "expected DropdbStmt, got ${Node.tag(n)}"
		}

	## `ExecuteStmt`
	ExecuteStmt : { name : Node.Text, params : List(Node) }

	execute_stmt_default : Node.ExecuteStmt
	execute_stmt_default = { name: Err(Null), params: [] }

	execute_stmt_of : Node -> Node.ExecuteStmt
	execute_stmt_of = |n|
		match n {
			ExecuteStmt(r) => r
			_ => crash "expected ExecuteStmt, got ${Node.tag(n)}"
		}

	## `ExplainStmt`
	ExplainStmt : { query : Node, options : List(Node) }

	explain_stmt_default : Node.ExplainStmt
	explain_stmt_default = { query: Node.null, options: [] }

	explain_stmt_of : Node -> Node.ExplainStmt
	explain_stmt_of = |n|
		match n {
			ExplainStmt(r) => r
			_ => crash "expected ExplainStmt, got ${Node.tag(n)}"
		}

	## `FetchStmt`
	FetchStmt : { direction : I64, how_many : I64, portalname : Node.Text, ismove : Bool }

	fetch_stmt_default : Node.FetchStmt
	fetch_stmt_default = { direction: 0.I64, how_many: 0.I64, portalname: Err(Null), ismove: Bool.False }

	fetch_stmt_of : Node -> Node.FetchStmt
	fetch_stmt_of = |n|
		match n {
			FetchStmt(r) => r
			_ => crash "expected FetchStmt, got ${Node.tag(n)}"
		}

	## `Float`
	Float : { fval : Node.Text }

	float_default : Node.Float
	float_default = { fval: Err(Null) }

	float_of : Node -> Node.Float
	float_of = |n|
		match n {
			Float(r) => r
			_ => crash "expected Float, got ${Node.tag(n)}"
		}

	## `FuncCall`
	FuncCall : { funcname : List(Node), args : List(Node), agg_order : List(Node), agg_filter : Node, over : Node, agg_within_group : Bool, agg_star : Bool, agg_distinct : Bool, func_variadic : Bool, funcformat : I64, location : I64 }

	func_call_default : Node.FuncCall
	func_call_default = { funcname: [], args: [], agg_order: [], agg_filter: Node.null, over: Node.null, agg_within_group: Bool.False, agg_star: Bool.False, agg_distinct: Bool.False, func_variadic: Bool.False, funcformat: 0.I64, location: 0.I64 }

	func_call_of : Node -> Node.FuncCall
	func_call_of = |n|
		match n {
			FuncCall(r) => r
			_ => crash "expected FuncCall, got ${Node.tag(n)}"
		}

	## `FunctionParameter`
	FunctionParameter : { name : Node.Text, arg_type : Node, mode : I64, defexpr : Node, location : I64 }

	function_parameter_default : Node.FunctionParameter
	function_parameter_default = { name: Err(Null), arg_type: Node.null, mode: 0.I64, defexpr: Node.null, location: 0.I64 }

	function_parameter_of : Node -> Node.FunctionParameter
	function_parameter_of = |n|
		match n {
			FunctionParameter(r) => r
			_ => crash "expected FunctionParameter, got ${Node.tag(n)}"
		}

	## `GrantRoleStmt`
	GrantRoleStmt : { granted_roles : List(Node), grantee_roles : List(Node), is_grant : Bool, opt : List(Node), grantor : Node, behavior : I64 }

	grant_role_stmt_default : Node.GrantRoleStmt
	grant_role_stmt_default = { granted_roles: [], grantee_roles: [], is_grant: Bool.False, opt: [], grantor: Node.null, behavior: 0.I64 }

	grant_role_stmt_of : Node -> Node.GrantRoleStmt
	grant_role_stmt_of = |n|
		match n {
			GrantRoleStmt(r) => r
			_ => crash "expected GrantRoleStmt, got ${Node.tag(n)}"
		}

	## `GrantStmt`
	GrantStmt : { is_grant : Bool, targtype : I64, objtype : I64, objects : List(Node), privileges : List(Node), grantees : List(Node), grant_option : Bool, grantor : Node, behavior : I64 }

	grant_stmt_default : Node.GrantStmt
	grant_stmt_default = { is_grant: Bool.False, targtype: 0.I64, objtype: 0.I64, objects: [], privileges: [], grantees: [], grant_option: Bool.False, grantor: Node.null, behavior: 0.I64 }

	grant_stmt_of : Node -> Node.GrantStmt
	grant_stmt_of = |n|
		match n {
			GrantStmt(r) => r
			_ => crash "expected GrantStmt, got ${Node.tag(n)}"
		}

	## `GroupClause`
	GroupClause : { distinct : Bool, list : List(Node) }

	group_clause_default : Node.GroupClause
	group_clause_default = { distinct: Bool.False, list: [] }

	group_clause_of : Node -> Node.GroupClause
	group_clause_of = |n|
		match n {
			GroupClause(r) => r
			_ => crash "expected GroupClause, got ${Node.tag(n)}"
		}

	## `GroupingFunc`
	GroupingFunc : { args : List(Node), refs : List(Node), cols : List(Node), agglevelsup : I64, location : I64 }

	grouping_func_default : Node.GroupingFunc
	grouping_func_default = { args: [], refs: [], cols: [], agglevelsup: 0.I64, location: 0.I64 }

	grouping_func_of : Node -> Node.GroupingFunc
	grouping_func_of = |n|
		match n {
			GroupingFunc(r) => r
			_ => crash "expected GroupingFunc, got ${Node.tag(n)}"
		}

	## `GroupingSet`
	GroupingSet : { kind : I64, content : List(Node), location : I64 }

	grouping_set_default : Node.GroupingSet
	grouping_set_default = { kind: 0.I64, content: [], location: 0.I64 }

	grouping_set_of : Node -> Node.GroupingSet
	grouping_set_of = |n|
		match n {
			GroupingSet(r) => r
			_ => crash "expected GroupingSet, got ${Node.tag(n)}"
		}

	## `ImportForeignSchemaStmt`
	ImportForeignSchemaStmt : { server_name : Node.Text, remote_schema : Node.Text, local_schema : Node.Text, list_type : I64, table_list : List(Node), options : List(Node) }

	import_foreign_schema_stmt_default : Node.ImportForeignSchemaStmt
	import_foreign_schema_stmt_default = { server_name: Err(Null), remote_schema: Err(Null), local_schema: Err(Null), list_type: 0.I64, table_list: [], options: [] }

	import_foreign_schema_stmt_of : Node -> Node.ImportForeignSchemaStmt
	import_foreign_schema_stmt_of = |n|
		match n {
			ImportForeignSchemaStmt(r) => r
			_ => crash "expected ImportForeignSchemaStmt, got ${Node.tag(n)}"
		}

	## `ImportQual`
	ImportQual : { type : I64, table_names : List(Node) }

	import_qual_default : Node.ImportQual
	import_qual_default = { type: 0.I64, table_names: [] }

	import_qual_of : Node -> Node.ImportQual
	import_qual_of = |n|
		match n {
			ImportQual(r) => r
			_ => crash "expected ImportQual, got ${Node.tag(n)}"
		}

	## `IndexElem`
	IndexElem : { name : Node.Text, expr : Node, indexcolname : Node.Text, collation : List(Node), opclass : List(Node), opclassopts : List(Node), ordering : I64, nulls_ordering : I64 }

	index_elem_default : Node.IndexElem
	index_elem_default = { name: Err(Null), expr: Node.null, indexcolname: Err(Null), collation: [], opclass: [], opclassopts: [], ordering: 0.I64, nulls_ordering: 0.I64 }

	index_elem_of : Node -> Node.IndexElem
	index_elem_of = |n|
		match n {
			IndexElem(r) => r
			_ => crash "expected IndexElem, got ${Node.tag(n)}"
		}

	## `IndexStmt`
	IndexStmt : { idxname : Node.Text, relation : Node, access_method : Node.Text, table_space : Node.Text, index_params : List(Node), index_including_params : List(Node), options : List(Node), where_clause : Node, exclude_op_names : List(Node), idxcomment : Node.Text, index_oid : I64, old_number : I64, old_create_subid : I64, old_first_relfilelocator_subid : I64, unique : Bool, nulls_not_distinct : Bool, primary : Bool, isconstraint : Bool, iswithoutoverlaps : Bool, deferrable : Bool, initdeferred : Bool, transformed : Bool, concurrent : Bool, if_not_exists : Bool, reset_default_tblspc : Bool }

	index_stmt_default : Node.IndexStmt
	index_stmt_default = { idxname: Err(Null), relation: Node.null, access_method: Err(Null), table_space: Err(Null), index_params: [], index_including_params: [], options: [], where_clause: Node.null, exclude_op_names: [], idxcomment: Err(Null), index_oid: 0.I64, old_number: 0.I64, old_create_subid: 0.I64, old_first_relfilelocator_subid: 0.I64, unique: Bool.False, nulls_not_distinct: Bool.False, primary: Bool.False, isconstraint: Bool.False, iswithoutoverlaps: Bool.False, deferrable: Bool.False, initdeferred: Bool.False, transformed: Bool.False, concurrent: Bool.False, if_not_exists: Bool.False, reset_default_tblspc: Bool.False }

	index_stmt_of : Node -> Node.IndexStmt
	index_stmt_of = |n|
		match n {
			IndexStmt(r) => r
			_ => crash "expected IndexStmt, got ${Node.tag(n)}"
		}

	## `InferClause`
	InferClause : { index_elems : List(Node), where_clause : Node, conname : Node.Text, location : I64 }

	infer_clause_default : Node.InferClause
	infer_clause_default = { index_elems: [], where_clause: Node.null, conname: Err(Null), location: 0.I64 }

	infer_clause_of : Node -> Node.InferClause
	infer_clause_of = |n|
		match n {
			InferClause(r) => r
			_ => crash "expected InferClause, got ${Node.tag(n)}"
		}

	## `InsertStmt`
	InsertStmt : { relation : Node, cols : List(Node), select_stmt : Node, on_conflict_clause : Node, returning_clause : Node, with_clause : Node, override : I64 }

	insert_stmt_default : Node.InsertStmt
	insert_stmt_default = { relation: Node.null, cols: [], select_stmt: Node.null, on_conflict_clause: Node.null, returning_clause: Node.null, with_clause: Node.null, override: 0.I64 }

	insert_stmt_of : Node -> Node.InsertStmt
	insert_stmt_of = |n|
		match n {
			InsertStmt(r) => r
			_ => crash "expected InsertStmt, got ${Node.tag(n)}"
		}

	## `Integer`
	Integer : { ival : I64 }

	integer_default : Node.Integer
	integer_default = { ival: 0.I64 }

	integer_of : Node -> Node.Integer
	integer_of = |n|
		match n {
			Integer(r) => r
			_ => crash "expected Integer, got ${Node.tag(n)}"
		}

	## `IntoClause`
	IntoClause : { rel : Node, col_names : List(Node), access_method : Node.Text, options : List(Node), on_commit : I64, table_space_name : Node.Text, view_query : Node, skip_data : Bool }

	into_clause_default : Node.IntoClause
	into_clause_default = { rel: Node.null, col_names: [], access_method: Err(Null), options: [], on_commit: 0.I64, table_space_name: Err(Null), view_query: Node.null, skip_data: Bool.False }

	into_clause_of : Node -> Node.IntoClause
	into_clause_of = |n|
		match n {
			IntoClause(r) => r
			_ => crash "expected IntoClause, got ${Node.tag(n)}"
		}

	## `JoinExpr`
	JoinExpr : { jointype : I64, is_natural : Bool, larg : Node, rarg : Node, using_clause : List(Node), join_using_alias : Node, quals : Node, alias : Node, rtindex : I64 }

	join_expr_default : Node.JoinExpr
	join_expr_default = { jointype: 0.I64, is_natural: Bool.False, larg: Node.null, rarg: Node.null, using_clause: [], join_using_alias: Node.null, quals: Node.null, alias: Node.null, rtindex: 0.I64 }

	join_expr_of : Node -> Node.JoinExpr
	join_expr_of = |n|
		match n {
			JoinExpr(r) => r
			_ => crash "expected JoinExpr, got ${Node.tag(n)}"
		}

	## `JsonAggConstructor`
	JsonAggConstructor : { output : Node, agg_filter : Node, agg_order : List(Node), over : Node, location : I64 }

	json_agg_constructor_default : Node.JsonAggConstructor
	json_agg_constructor_default = { output: Node.null, agg_filter: Node.null, agg_order: [], over: Node.null, location: 0.I64 }

	json_agg_constructor_of : Node -> Node.JsonAggConstructor
	json_agg_constructor_of = |n|
		match n {
			JsonAggConstructor(r) => r
			_ => crash "expected JsonAggConstructor, got ${Node.tag(n)}"
		}

	## `JsonArgument`
	JsonArgument : { val : Node, name : Node.Text }

	json_argument_default : Node.JsonArgument
	json_argument_default = { val: Node.null, name: Err(Null) }

	json_argument_of : Node -> Node.JsonArgument
	json_argument_of = |n|
		match n {
			JsonArgument(r) => r
			_ => crash "expected JsonArgument, got ${Node.tag(n)}"
		}

	## `JsonArrayAgg`
	JsonArrayAgg : { constructor : Node, arg : Node, absent_on_null : Bool }

	json_array_agg_default : Node.JsonArrayAgg
	json_array_agg_default = { constructor: Node.null, arg: Node.null, absent_on_null: Bool.False }

	json_array_agg_of : Node -> Node.JsonArrayAgg
	json_array_agg_of = |n|
		match n {
			JsonArrayAgg(r) => r
			_ => crash "expected JsonArrayAgg, got ${Node.tag(n)}"
		}

	## `JsonArrayConstructor`
	JsonArrayConstructor : { exprs : List(Node), output : Node, absent_on_null : Bool, location : I64 }

	json_array_constructor_default : Node.JsonArrayConstructor
	json_array_constructor_default = { exprs: [], output: Node.null, absent_on_null: Bool.False, location: 0.I64 }

	json_array_constructor_of : Node -> Node.JsonArrayConstructor
	json_array_constructor_of = |n|
		match n {
			JsonArrayConstructor(r) => r
			_ => crash "expected JsonArrayConstructor, got ${Node.tag(n)}"
		}

	## `JsonArrayQueryConstructor`
	JsonArrayQueryConstructor : { query : Node, output : Node, format : Node, absent_on_null : Bool, location : I64 }

	json_array_query_constructor_default : Node.JsonArrayQueryConstructor
	json_array_query_constructor_default = { query: Node.null, output: Node.null, format: Node.null, absent_on_null: Bool.False, location: 0.I64 }

	json_array_query_constructor_of : Node -> Node.JsonArrayQueryConstructor
	json_array_query_constructor_of = |n|
		match n {
			JsonArrayQueryConstructor(r) => r
			_ => crash "expected JsonArrayQueryConstructor, got ${Node.tag(n)}"
		}

	## `JsonBehavior`
	JsonBehavior : { btype : I64, expr : Node, coerce : Bool, location : I64 }

	json_behavior_default : Node.JsonBehavior
	json_behavior_default = { btype: 0.I64, expr: Node.null, coerce: Bool.False, location: 0.I64 }

	json_behavior_of : Node -> Node.JsonBehavior
	json_behavior_of = |n|
		match n {
			JsonBehavior(r) => r
			_ => crash "expected JsonBehavior, got ${Node.tag(n)}"
		}

	## `JsonFormat`
	JsonFormat : { format_type : I64, encoding : I64, location : I64 }

	json_format_default : Node.JsonFormat
	json_format_default = { format_type: 0.I64, encoding: 0.I64, location: 0.I64 }

	json_format_of : Node -> Node.JsonFormat
	json_format_of = |n|
		match n {
			JsonFormat(r) => r
			_ => crash "expected JsonFormat, got ${Node.tag(n)}"
		}

	## `JsonFuncExpr`
	JsonFuncExpr : { op : I64, column_name : Node.Text, context_item : Node, pathspec : Node, passing : List(Node), output : Node, on_empty : Node, on_error : Node, wrapper : I64, quotes : I64, location : I64 }

	json_func_expr_default : Node.JsonFuncExpr
	json_func_expr_default = { op: 0.I64, column_name: Err(Null), context_item: Node.null, pathspec: Node.null, passing: [], output: Node.null, on_empty: Node.null, on_error: Node.null, wrapper: 0.I64, quotes: 0.I64, location: 0.I64 }

	json_func_expr_of : Node -> Node.JsonFuncExpr
	json_func_expr_of = |n|
		match n {
			JsonFuncExpr(r) => r
			_ => crash "expected JsonFuncExpr, got ${Node.tag(n)}"
		}

	## `JsonIsPredicate`
	JsonIsPredicate : { expr : Node, format : Node, item_type : I64, unique_keys : Bool, location : I64 }

	json_is_predicate_default : Node.JsonIsPredicate
	json_is_predicate_default = { expr: Node.null, format: Node.null, item_type: 0.I64, unique_keys: Bool.False, location: 0.I64 }

	json_is_predicate_of : Node -> Node.JsonIsPredicate
	json_is_predicate_of = |n|
		match n {
			JsonIsPredicate(r) => r
			_ => crash "expected JsonIsPredicate, got ${Node.tag(n)}"
		}

	## `JsonKeyValue`
	JsonKeyValue : { key : Node, value : Node }

	json_key_value_default : Node.JsonKeyValue
	json_key_value_default = { key: Node.null, value: Node.null }

	json_key_value_of : Node -> Node.JsonKeyValue
	json_key_value_of = |n|
		match n {
			JsonKeyValue(r) => r
			_ => crash "expected JsonKeyValue, got ${Node.tag(n)}"
		}

	## `JsonObjectAgg`
	JsonObjectAgg : { constructor : Node, arg : Node, absent_on_null : Bool, unique : Bool }

	json_object_agg_default : Node.JsonObjectAgg
	json_object_agg_default = { constructor: Node.null, arg: Node.null, absent_on_null: Bool.False, unique: Bool.False }

	json_object_agg_of : Node -> Node.JsonObjectAgg
	json_object_agg_of = |n|
		match n {
			JsonObjectAgg(r) => r
			_ => crash "expected JsonObjectAgg, got ${Node.tag(n)}"
		}

	## `JsonObjectConstructor`
	JsonObjectConstructor : { exprs : List(Node), output : Node, absent_on_null : Bool, unique : Bool, location : I64 }

	json_object_constructor_default : Node.JsonObjectConstructor
	json_object_constructor_default = { exprs: [], output: Node.null, absent_on_null: Bool.False, unique: Bool.False, location: 0.I64 }

	json_object_constructor_of : Node -> Node.JsonObjectConstructor
	json_object_constructor_of = |n|
		match n {
			JsonObjectConstructor(r) => r
			_ => crash "expected JsonObjectConstructor, got ${Node.tag(n)}"
		}

	## `JsonOutput`
	JsonOutput : { type_name : Node, returning : Node }

	json_output_default : Node.JsonOutput
	json_output_default = { type_name: Node.null, returning: Node.null }

	json_output_of : Node -> Node.JsonOutput
	json_output_of = |n|
		match n {
			JsonOutput(r) => r
			_ => crash "expected JsonOutput, got ${Node.tag(n)}"
		}

	## `JsonParseExpr`
	JsonParseExpr : { expr : Node, output : Node, unique_keys : Bool, location : I64 }

	json_parse_expr_default : Node.JsonParseExpr
	json_parse_expr_default = { expr: Node.null, output: Node.null, unique_keys: Bool.False, location: 0.I64 }

	json_parse_expr_of : Node -> Node.JsonParseExpr
	json_parse_expr_of = |n|
		match n {
			JsonParseExpr(r) => r
			_ => crash "expected JsonParseExpr, got ${Node.tag(n)}"
		}

	## `JsonReturning`
	JsonReturning : { format : Node, typid : I64, typmod : I64 }

	json_returning_default : Node.JsonReturning
	json_returning_default = { format: Node.null, typid: 0.I64, typmod: 0.I64 }

	json_returning_of : Node -> Node.JsonReturning
	json_returning_of = |n|
		match n {
			JsonReturning(r) => r
			_ => crash "expected JsonReturning, got ${Node.tag(n)}"
		}

	## `JsonScalarExpr`
	JsonScalarExpr : { expr : Node, output : Node, location : I64 }

	json_scalar_expr_default : Node.JsonScalarExpr
	json_scalar_expr_default = { expr: Node.null, output: Node.null, location: 0.I64 }

	json_scalar_expr_of : Node -> Node.JsonScalarExpr
	json_scalar_expr_of = |n|
		match n {
			JsonScalarExpr(r) => r
			_ => crash "expected JsonScalarExpr, got ${Node.tag(n)}"
		}

	## `JsonSerializeExpr`
	JsonSerializeExpr : { expr : Node, output : Node, location : I64 }

	json_serialize_expr_default : Node.JsonSerializeExpr
	json_serialize_expr_default = { expr: Node.null, output: Node.null, location: 0.I64 }

	json_serialize_expr_of : Node -> Node.JsonSerializeExpr
	json_serialize_expr_of = |n|
		match n {
			JsonSerializeExpr(r) => r
			_ => crash "expected JsonSerializeExpr, got ${Node.tag(n)}"
		}

	## `JsonTable`
	JsonTable : { context_item : Node, pathspec : Node, passing : List(Node), columns : List(Node), on_error : Node, alias : Node, lateral : Bool, location : I64 }

	json_table_default : Node.JsonTable
	json_table_default = { context_item: Node.null, pathspec: Node.null, passing: [], columns: [], on_error: Node.null, alias: Node.null, lateral: Bool.False, location: 0.I64 }

	json_table_of : Node -> Node.JsonTable
	json_table_of = |n|
		match n {
			JsonTable(r) => r
			_ => crash "expected JsonTable, got ${Node.tag(n)}"
		}

	## `JsonTableColumn`
	JsonTableColumn : { coltype : I64, name : Node.Text, type_name : Node, pathspec : Node, format : Node, wrapper : I64, quotes : I64, columns : List(Node), on_empty : Node, on_error : Node, location : I64 }

	json_table_column_default : Node.JsonTableColumn
	json_table_column_default = { coltype: 0.I64, name: Err(Null), type_name: Node.null, pathspec: Node.null, format: Node.null, wrapper: 0.I64, quotes: 0.I64, columns: [], on_empty: Node.null, on_error: Node.null, location: 0.I64 }

	json_table_column_of : Node -> Node.JsonTableColumn
	json_table_column_of = |n|
		match n {
			JsonTableColumn(r) => r
			_ => crash "expected JsonTableColumn, got ${Node.tag(n)}"
		}

	## `JsonTablePathSpec`
	JsonTablePathSpec : { string : Node, name : Node.Text, name_location : I64, location : I64 }

	json_table_path_spec_default : Node.JsonTablePathSpec
	json_table_path_spec_default = { string: Node.null, name: Err(Null), name_location: 0.I64, location: 0.I64 }

	json_table_path_spec_of : Node -> Node.JsonTablePathSpec
	json_table_path_spec_of = |n|
		match n {
			JsonTablePathSpec(r) => r
			_ => crash "expected JsonTablePathSpec, got ${Node.tag(n)}"
		}

	## `JsonValueExpr`
	JsonValueExpr : { raw_expr : Node, formatted_expr : Node, format : Node }

	json_value_expr_default : Node.JsonValueExpr
	json_value_expr_default = { raw_expr: Node.null, formatted_expr: Node.null, format: Node.null }

	json_value_expr_of : Node -> Node.JsonValueExpr
	json_value_expr_of = |n|
		match n {
			JsonValueExpr(r) => r
			_ => crash "expected JsonValueExpr, got ${Node.tag(n)}"
		}

	## `KeyAction`
	KeyAction : { action : I64, cols : List(Node) }

	key_action_default : Node.KeyAction
	key_action_default = { action: 0.I64, cols: [] }

	key_action_of : Node -> Node.KeyAction
	key_action_of = |n|
		match n {
			KeyAction(r) => r
			_ => crash "expected KeyAction, got ${Node.tag(n)}"
		}

	## `KeyActions`
	KeyActions : { update_action : Node, delete_action : Node }

	key_actions_default : Node.KeyActions
	key_actions_default = { update_action: Node.null, delete_action: Node.null }

	key_actions_of : Node -> Node.KeyActions
	key_actions_of = |n|
		match n {
			KeyActions(r) => r
			_ => crash "expected KeyActions, got ${Node.tag(n)}"
		}

	## `ListenStmt`
	ListenStmt : { conditionname : Node.Text }

	listen_stmt_default : Node.ListenStmt
	listen_stmt_default = { conditionname: Err(Null) }

	listen_stmt_of : Node -> Node.ListenStmt
	listen_stmt_of = |n|
		match n {
			ListenStmt(r) => r
			_ => crash "expected ListenStmt, got ${Node.tag(n)}"
		}

	## `LoadStmt`
	LoadStmt : { filename : Node.Text }

	load_stmt_default : Node.LoadStmt
	load_stmt_default = { filename: Err(Null) }

	load_stmt_of : Node -> Node.LoadStmt
	load_stmt_of = |n|
		match n {
			LoadStmt(r) => r
			_ => crash "expected LoadStmt, got ${Node.tag(n)}"
		}

	## `LockStmt`
	LockStmt : { relations : List(Node), mode : I64, nowait : Bool }

	lock_stmt_default : Node.LockStmt
	lock_stmt_default = { relations: [], mode: 0.I64, nowait: Bool.False }

	lock_stmt_of : Node -> Node.LockStmt
	lock_stmt_of = |n|
		match n {
			LockStmt(r) => r
			_ => crash "expected LockStmt, got ${Node.tag(n)}"
		}

	## `LockingClause`
	LockingClause : { locked_rels : List(Node), strength : I64, wait_policy : I64 }

	locking_clause_default : Node.LockingClause
	locking_clause_default = { locked_rels: [], strength: 0.I64, wait_policy: 0.I64 }

	locking_clause_of : Node -> Node.LockingClause
	locking_clause_of = |n|
		match n {
			LockingClause(r) => r
			_ => crash "expected LockingClause, got ${Node.tag(n)}"
		}

	## `MergeStmt`
	MergeStmt : { relation : Node, source_relation : Node, join_condition : Node, merge_when_clauses : List(Node), returning_clause : Node, with_clause : Node }

	merge_stmt_default : Node.MergeStmt
	merge_stmt_default = { relation: Node.null, source_relation: Node.null, join_condition: Node.null, merge_when_clauses: [], returning_clause: Node.null, with_clause: Node.null }

	merge_stmt_of : Node -> Node.MergeStmt
	merge_stmt_of = |n|
		match n {
			MergeStmt(r) => r
			_ => crash "expected MergeStmt, got ${Node.tag(n)}"
		}

	## `MergeSupportFunc`
	MergeSupportFunc : { msftype : I64, msfcollid : I64, location : I64 }

	merge_support_func_default : Node.MergeSupportFunc
	merge_support_func_default = { msftype: 0.I64, msfcollid: 0.I64, location: 0.I64 }

	merge_support_func_of : Node -> Node.MergeSupportFunc
	merge_support_func_of = |n|
		match n {
			MergeSupportFunc(r) => r
			_ => crash "expected MergeSupportFunc, got ${Node.tag(n)}"
		}

	## `MergeWhenClause`
	MergeWhenClause : { match_kind : I64, command_type : I64, override : I64, condition : Node, target_list : List(Node), values : List(Node) }

	merge_when_clause_default : Node.MergeWhenClause
	merge_when_clause_default = { match_kind: 0.I64, command_type: 0.I64, override: 0.I64, condition: Node.null, target_list: [], values: [] }

	merge_when_clause_of : Node -> Node.MergeWhenClause
	merge_when_clause_of = |n|
		match n {
			MergeWhenClause(r) => r
			_ => crash "expected MergeWhenClause, got ${Node.tag(n)}"
		}

	## `MinMaxExpr`
	MinMaxExpr : { minmaxtype : I64, minmaxcollid : I64, inputcollid : I64, op : I64, args : List(Node), location : I64 }

	min_max_expr_default : Node.MinMaxExpr
	min_max_expr_default = { minmaxtype: 0.I64, minmaxcollid: 0.I64, inputcollid: 0.I64, op: 0.I64, args: [], location: 0.I64 }

	min_max_expr_of : Node -> Node.MinMaxExpr
	min_max_expr_of = |n|
		match n {
			MinMaxExpr(r) => r
			_ => crash "expected MinMaxExpr, got ${Node.tag(n)}"
		}

	## `MultiAssignRef`
	MultiAssignRef : { source : Node, colno : I64, ncolumns : I64 }

	multi_assign_ref_default : Node.MultiAssignRef
	multi_assign_ref_default = { source: Node.null, colno: 0.I64, ncolumns: 0.I64 }

	multi_assign_ref_of : Node -> Node.MultiAssignRef
	multi_assign_ref_of = |n|
		match n {
			MultiAssignRef(r) => r
			_ => crash "expected MultiAssignRef, got ${Node.tag(n)}"
		}

	## `NamedArgExpr`
	NamedArgExpr : { arg : Node, name : Node.Text, argnumber : I64, location : I64 }

	named_arg_expr_default : Node.NamedArgExpr
	named_arg_expr_default = { arg: Node.null, name: Err(Null), argnumber: 0.I64, location: 0.I64 }

	named_arg_expr_of : Node -> Node.NamedArgExpr
	named_arg_expr_of = |n|
		match n {
			NamedArgExpr(r) => r
			_ => crash "expected NamedArgExpr, got ${Node.tag(n)}"
		}

	## `NotifyStmt`
	NotifyStmt : { conditionname : Node.Text, payload : Node.Text }

	notify_stmt_default : Node.NotifyStmt
	notify_stmt_default = { conditionname: Err(Null), payload: Err(Null) }

	notify_stmt_of : Node -> Node.NotifyStmt
	notify_stmt_of = |n|
		match n {
			NotifyStmt(r) => r
			_ => crash "expected NotifyStmt, got ${Node.tag(n)}"
		}

	## `NullTest`
	NullTest : { arg : Node, nulltesttype : I64, argisrow : Bool, location : I64 }

	null_test_default : Node.NullTest
	null_test_default = { arg: Node.null, nulltesttype: 0.I64, argisrow: Bool.False, location: 0.I64 }

	null_test_of : Node -> Node.NullTest
	null_test_of = |n|
		match n {
			NullTest(r) => r
			_ => crash "expected NullTest, got ${Node.tag(n)}"
		}

	## `ObjectWithArgs`
	ObjectWithArgs : { objname : List(Node), objargs : List(Node), objfuncargs : List(Node), args_unspecified : Bool }

	object_with_args_default : Node.ObjectWithArgs
	object_with_args_default = { objname: [], objargs: [], objfuncargs: [], args_unspecified: Bool.False }

	object_with_args_of : Node -> Node.ObjectWithArgs
	object_with_args_of = |n|
		match n {
			ObjectWithArgs(r) => r
			_ => crash "expected ObjectWithArgs, got ${Node.tag(n)}"
		}

	## `OnConflictClause`
	OnConflictClause : { action : I64, infer : Node, target_list : List(Node), where_clause : Node, location : I64 }

	on_conflict_clause_default : Node.OnConflictClause
	on_conflict_clause_default = { action: 0.I64, infer: Node.null, target_list: [], where_clause: Node.null, location: 0.I64 }

	on_conflict_clause_of : Node -> Node.OnConflictClause
	on_conflict_clause_of = |n|
		match n {
			OnConflictClause(r) => r
			_ => crash "expected OnConflictClause, got ${Node.tag(n)}"
		}

	## `PLAssignStmt`
	PLAssignStmt : { name : Node.Text, indirection : List(Node), nnames : I64, val : Node, location : I64 }

	pl_assign_stmt_default : Node.PLAssignStmt
	pl_assign_stmt_default = { name: Err(Null), indirection: [], nnames: 0.I64, val: Node.null, location: 0.I64 }

	pl_assign_stmt_of : Node -> Node.PLAssignStmt
	pl_assign_stmt_of = |n|
		match n {
			PLAssignStmt(r) => r
			_ => crash "expected PLAssignStmt, got ${Node.tag(n)}"
		}

	## `ParamRef`
	ParamRef : { number : I64, location : I64 }

	param_ref_default : Node.ParamRef
	param_ref_default = { number: 0.I64, location: 0.I64 }

	param_ref_of : Node -> Node.ParamRef
	param_ref_of = |n|
		match n {
			ParamRef(r) => r
			_ => crash "expected ParamRef, got ${Node.tag(n)}"
		}

	## `PartitionBoundSpec`
	PartitionBoundSpec : { strategy : I64, is_default : Bool, modulus : I64, remainder : I64, listdatums : List(Node), lowerdatums : List(Node), upperdatums : List(Node), location : I64 }

	partition_bound_spec_default : Node.PartitionBoundSpec
	partition_bound_spec_default = { strategy: 0.I64, is_default: Bool.False, modulus: 0.I64, remainder: 0.I64, listdatums: [], lowerdatums: [], upperdatums: [], location: 0.I64 }

	partition_bound_spec_of : Node -> Node.PartitionBoundSpec
	partition_bound_spec_of = |n|
		match n {
			PartitionBoundSpec(r) => r
			_ => crash "expected PartitionBoundSpec, got ${Node.tag(n)}"
		}

	## `PartitionCmd`
	PartitionCmd : { name : Node, bound : Node, concurrent : Bool }

	partition_cmd_default : Node.PartitionCmd
	partition_cmd_default = { name: Node.null, bound: Node.null, concurrent: Bool.False }

	partition_cmd_of : Node -> Node.PartitionCmd
	partition_cmd_of = |n|
		match n {
			PartitionCmd(r) => r
			_ => crash "expected PartitionCmd, got ${Node.tag(n)}"
		}

	## `PartitionElem`
	PartitionElem : { name : Node.Text, expr : Node, collation : List(Node), opclass : List(Node), location : I64 }

	partition_elem_default : Node.PartitionElem
	partition_elem_default = { name: Err(Null), expr: Node.null, collation: [], opclass: [], location: 0.I64 }

	partition_elem_of : Node -> Node.PartitionElem
	partition_elem_of = |n|
		match n {
			PartitionElem(r) => r
			_ => crash "expected PartitionElem, got ${Node.tag(n)}"
		}

	## `PartitionSpec`
	PartitionSpec : { strategy : I64, part_params : List(Node), location : I64 }

	partition_spec_default : Node.PartitionSpec
	partition_spec_default = { strategy: 0.I64, part_params: [], location: 0.I64 }

	partition_spec_of : Node -> Node.PartitionSpec
	partition_spec_of = |n|
		match n {
			PartitionSpec(r) => r
			_ => crash "expected PartitionSpec, got ${Node.tag(n)}"
		}

	## `PrepareStmt`
	PrepareStmt : { name : Node.Text, argtypes : List(Node), query : Node }

	prepare_stmt_default : Node.PrepareStmt
	prepare_stmt_default = { name: Err(Null), argtypes: [], query: Node.null }

	prepare_stmt_of : Node -> Node.PrepareStmt
	prepare_stmt_of = |n|
		match n {
			PrepareStmt(r) => r
			_ => crash "expected PrepareStmt, got ${Node.tag(n)}"
		}

	## `PrivTarget`
	PrivTarget : { targtype : I64, objtype : I64, objs : List(Node) }

	priv_target_default : Node.PrivTarget
	priv_target_default = { targtype: 0.I64, objtype: 0.I64, objs: [] }

	priv_target_of : Node -> Node.PrivTarget
	priv_target_of = |n|
		match n {
			PrivTarget(r) => r
			_ => crash "expected PrivTarget, got ${Node.tag(n)}"
		}

	## `PublicationObjSpec`
	PublicationObjSpec : { pubobjtype : I64, name : Node.Text, pubtable : Node, location : I64 }

	publication_obj_spec_default : Node.PublicationObjSpec
	publication_obj_spec_default = { pubobjtype: 0.I64, name: Err(Null), pubtable: Node.null, location: 0.I64 }

	publication_obj_spec_of : Node -> Node.PublicationObjSpec
	publication_obj_spec_of = |n|
		match n {
			PublicationObjSpec(r) => r
			_ => crash "expected PublicationObjSpec, got ${Node.tag(n)}"
		}

	## `PublicationTable`
	PublicationTable : { relation : Node, where_clause : Node, columns : List(Node) }

	publication_table_default : Node.PublicationTable
	publication_table_default = { relation: Node.null, where_clause: Node.null, columns: [] }

	publication_table_of : Node -> Node.PublicationTable
	publication_table_of = |n|
		match n {
			PublicationTable(r) => r
			_ => crash "expected PublicationTable, got ${Node.tag(n)}"
		}

	## `RangeFunction`
	RangeFunction : { lateral : Bool, ordinality : Bool, is_rowsfrom : Bool, functions : List(Node), alias : Node, coldeflist : List(Node) }

	range_function_default : Node.RangeFunction
	range_function_default = { lateral: Bool.False, ordinality: Bool.False, is_rowsfrom: Bool.False, functions: [], alias: Node.null, coldeflist: [] }

	range_function_of : Node -> Node.RangeFunction
	range_function_of = |n|
		match n {
			RangeFunction(r) => r
			_ => crash "expected RangeFunction, got ${Node.tag(n)}"
		}

	## `RangeSubselect`
	RangeSubselect : { lateral : Bool, subquery : Node, alias : Node }

	range_subselect_default : Node.RangeSubselect
	range_subselect_default = { lateral: Bool.False, subquery: Node.null, alias: Node.null }

	range_subselect_of : Node -> Node.RangeSubselect
	range_subselect_of = |n|
		match n {
			RangeSubselect(r) => r
			_ => crash "expected RangeSubselect, got ${Node.tag(n)}"
		}

	## `RangeTableFunc`
	RangeTableFunc : { lateral : Bool, docexpr : Node, rowexpr : Node, namespaces : List(Node), columns : List(Node), alias : Node, location : I64 }

	range_table_func_default : Node.RangeTableFunc
	range_table_func_default = { lateral: Bool.False, docexpr: Node.null, rowexpr: Node.null, namespaces: [], columns: [], alias: Node.null, location: 0.I64 }

	range_table_func_of : Node -> Node.RangeTableFunc
	range_table_func_of = |n|
		match n {
			RangeTableFunc(r) => r
			_ => crash "expected RangeTableFunc, got ${Node.tag(n)}"
		}

	## `RangeTableFuncCol`
	RangeTableFuncCol : { colname : Node.Text, type_name : Node, for_ordinality : Bool, is_not_null : Bool, colexpr : Node, coldefexpr : Node, location : I64 }

	range_table_func_col_default : Node.RangeTableFuncCol
	range_table_func_col_default = { colname: Err(Null), type_name: Node.null, for_ordinality: Bool.False, is_not_null: Bool.False, colexpr: Node.null, coldefexpr: Node.null, location: 0.I64 }

	range_table_func_col_of : Node -> Node.RangeTableFuncCol
	range_table_func_col_of = |n|
		match n {
			RangeTableFuncCol(r) => r
			_ => crash "expected RangeTableFuncCol, got ${Node.tag(n)}"
		}

	## `RangeTableSample`
	RangeTableSample : { relation : Node, method : List(Node), args : List(Node), repeatable : Node, location : I64 }

	range_table_sample_default : Node.RangeTableSample
	range_table_sample_default = { relation: Node.null, method: [], args: [], repeatable: Node.null, location: 0.I64 }

	range_table_sample_of : Node -> Node.RangeTableSample
	range_table_sample_of = |n|
		match n {
			RangeTableSample(r) => r
			_ => crash "expected RangeTableSample, got ${Node.tag(n)}"
		}

	## `RangeVar`
	RangeVar : { catalogname : Node.Text, schemaname : Node.Text, relname : Node.Text, inh : Bool, relpersistence : I64, alias : Node, location : I64 }

	range_var_default : Node.RangeVar
	range_var_default = { catalogname: Err(Null), schemaname: Err(Null), relname: Err(Null), inh: Bool.False, relpersistence: 0.I64, alias: Node.null, location: 0.I64 }

	range_var_of : Node -> Node.RangeVar
	range_var_of = |n|
		match n {
			RangeVar(r) => r
			_ => crash "expected RangeVar, got ${Node.tag(n)}"
		}

	## `RawStmt`
	RawStmt : { stmt : Node, stmt_location : I64, stmt_len : I64 }

	raw_stmt_default : Node.RawStmt
	raw_stmt_default = { stmt: Node.null, stmt_location: 0.I64, stmt_len: 0.I64 }

	raw_stmt_of : Node -> Node.RawStmt
	raw_stmt_of = |n|
		match n {
			RawStmt(r) => r
			_ => crash "expected RawStmt, got ${Node.tag(n)}"
		}

	## `ReassignOwnedStmt`
	ReassignOwnedStmt : { roles : List(Node), newrole : Node }

	reassign_owned_stmt_default : Node.ReassignOwnedStmt
	reassign_owned_stmt_default = { roles: [], newrole: Node.null }

	reassign_owned_stmt_of : Node -> Node.ReassignOwnedStmt
	reassign_owned_stmt_of = |n|
		match n {
			ReassignOwnedStmt(r) => r
			_ => crash "expected ReassignOwnedStmt, got ${Node.tag(n)}"
		}

	## `RefreshMatViewStmt`
	RefreshMatViewStmt : { concurrent : Bool, skip_data : Bool, relation : Node }

	refresh_mat_view_stmt_default : Node.RefreshMatViewStmt
	refresh_mat_view_stmt_default = { concurrent: Bool.False, skip_data: Bool.False, relation: Node.null }

	refresh_mat_view_stmt_of : Node -> Node.RefreshMatViewStmt
	refresh_mat_view_stmt_of = |n|
		match n {
			RefreshMatViewStmt(r) => r
			_ => crash "expected RefreshMatViewStmt, got ${Node.tag(n)}"
		}

	## `ReindexStmt`
	ReindexStmt : { kind : I64, relation : Node, name : Node.Text, params : List(Node) }

	reindex_stmt_default : Node.ReindexStmt
	reindex_stmt_default = { kind: 0.I64, relation: Node.null, name: Err(Null), params: [] }

	reindex_stmt_of : Node -> Node.ReindexStmt
	reindex_stmt_of = |n|
		match n {
			ReindexStmt(r) => r
			_ => crash "expected ReindexStmt, got ${Node.tag(n)}"
		}

	## `RenameStmt`
	RenameStmt : { rename_type : I64, relation_type : I64, relation : Node, object : Node, subname : Node.Text, newname : Node.Text, behavior : I64, missing_ok : Bool }

	rename_stmt_default : Node.RenameStmt
	rename_stmt_default = { rename_type: 0.I64, relation_type: 0.I64, relation: Node.null, object: Node.null, subname: Err(Null), newname: Err(Null), behavior: 0.I64, missing_ok: Bool.False }

	rename_stmt_of : Node -> Node.RenameStmt
	rename_stmt_of = |n|
		match n {
			RenameStmt(r) => r
			_ => crash "expected RenameStmt, got ${Node.tag(n)}"
		}

	## `ReplicaIdentityStmt`
	ReplicaIdentityStmt : { identity_type : I64, name : Node.Text }

	replica_identity_stmt_default : Node.ReplicaIdentityStmt
	replica_identity_stmt_default = { identity_type: 0.I64, name: Err(Null) }

	replica_identity_stmt_of : Node -> Node.ReplicaIdentityStmt
	replica_identity_stmt_of = |n|
		match n {
			ReplicaIdentityStmt(r) => r
			_ => crash "expected ReplicaIdentityStmt, got ${Node.tag(n)}"
		}

	## `ResTarget`
	ResTarget : { name : Node.Text, indirection : List(Node), val : Node, location : I64 }

	res_target_default : Node.ResTarget
	res_target_default = { name: Err(Null), indirection: [], val: Node.null, location: 0.I64 }

	res_target_of : Node -> Node.ResTarget
	res_target_of = |n|
		match n {
			ResTarget(r) => r
			_ => crash "expected ResTarget, got ${Node.tag(n)}"
		}

	## `ReturnStmt`
	ReturnStmt : { returnval : Node }

	return_stmt_default : Node.ReturnStmt
	return_stmt_default = { returnval: Node.null }

	return_stmt_of : Node -> Node.ReturnStmt
	return_stmt_of = |n|
		match n {
			ReturnStmt(r) => r
			_ => crash "expected ReturnStmt, got ${Node.tag(n)}"
		}

	## `ReturningClause`
	ReturningClause : { options : List(Node), exprs : List(Node) }

	returning_clause_default : Node.ReturningClause
	returning_clause_default = { options: [], exprs: [] }

	returning_clause_of : Node -> Node.ReturningClause
	returning_clause_of = |n|
		match n {
			ReturningClause(r) => r
			_ => crash "expected ReturningClause, got ${Node.tag(n)}"
		}

	## `ReturningOption`
	ReturningOption : { option : I64, value : Node.Text, location : I64 }

	returning_option_default : Node.ReturningOption
	returning_option_default = { option: 0.I64, value: Err(Null), location: 0.I64 }

	returning_option_of : Node -> Node.ReturningOption
	returning_option_of = |n|
		match n {
			ReturningOption(r) => r
			_ => crash "expected ReturningOption, got ${Node.tag(n)}"
		}

	## `RoleSpec`
	RoleSpec : { roletype : I64, rolename : Node.Text, location : I64 }

	role_spec_default : Node.RoleSpec
	role_spec_default = { roletype: 0.I64, rolename: Err(Null), location: 0.I64 }

	role_spec_of : Node -> Node.RoleSpec
	role_spec_of = |n|
		match n {
			RoleSpec(r) => r
			_ => crash "expected RoleSpec, got ${Node.tag(n)}"
		}

	## `RowExpr`
	RowExpr : { args : List(Node), row_typeid : I64, row_format : I64, colnames : List(Node), location : I64 }

	row_expr_default : Node.RowExpr
	row_expr_default = { args: [], row_typeid: 0.I64, row_format: 0.I64, colnames: [], location: 0.I64 }

	row_expr_of : Node -> Node.RowExpr
	row_expr_of = |n|
		match n {
			RowExpr(r) => r
			_ => crash "expected RowExpr, got ${Node.tag(n)}"
		}

	## `RuleStmt`
	RuleStmt : { relation : Node, rulename : Node.Text, where_clause : Node, event : I64, instead : Bool, actions : List(Node), replace : Bool }

	rule_stmt_default : Node.RuleStmt
	rule_stmt_default = { relation: Node.null, rulename: Err(Null), where_clause: Node.null, event: 0.I64, instead: Bool.False, actions: [], replace: Bool.False }

	rule_stmt_of : Node -> Node.RuleStmt
	rule_stmt_of = |n|
		match n {
			RuleStmt(r) => r
			_ => crash "expected RuleStmt, got ${Node.tag(n)}"
		}

	## `SQLValueFunction`
	SQLValueFunction : { op : I64, type : I64, typmod : I64, location : I64 }

	sql_value_function_default : Node.SQLValueFunction
	sql_value_function_default = { op: 0.I64, type: 0.I64, typmod: 0.I64, location: 0.I64 }

	sql_value_function_of : Node -> Node.SQLValueFunction
	sql_value_function_of = |n|
		match n {
			SQLValueFunction(r) => r
			_ => crash "expected SQLValueFunction, got ${Node.tag(n)}"
		}

	## `SecLabelStmt`
	SecLabelStmt : { objtype : I64, object : Node, provider : Node.Text, label : Node.Text }

	sec_label_stmt_default : Node.SecLabelStmt
	sec_label_stmt_default = { objtype: 0.I64, object: Node.null, provider: Err(Null), label: Err(Null) }

	sec_label_stmt_of : Node -> Node.SecLabelStmt
	sec_label_stmt_of = |n|
		match n {
			SecLabelStmt(r) => r
			_ => crash "expected SecLabelStmt, got ${Node.tag(n)}"
		}

	## `SelectLimit`
	SelectLimit : { limit_offset : Node, limit_count : Node, limit_option : I64, offset_loc : I64, count_loc : I64, option_loc : I64 }

	select_limit_default : Node.SelectLimit
	select_limit_default = { limit_offset: Node.null, limit_count: Node.null, limit_option: 0.I64, offset_loc: 0.I64, count_loc: 0.I64, option_loc: 0.I64 }

	select_limit_of : Node -> Node.SelectLimit
	select_limit_of = |n|
		match n {
			SelectLimit(r) => r
			_ => crash "expected SelectLimit, got ${Node.tag(n)}"
		}

	## `SelectStmt`
	SelectStmt : { distinct_clause : List(Node), into_clause : Node, target_list : List(Node), from_clause : List(Node), where_clause : Node, group_clause : List(Node), group_distinct : Bool, having_clause : Node, window_clause : List(Node), values_lists : List(Node), sort_clause : List(Node), limit_offset : Node, limit_count : Node, limit_option : I64, locking_clause : List(Node), with_clause : Node, op : I64, all : Bool, larg : Node, rarg : Node }

	select_stmt_default : Node.SelectStmt
	select_stmt_default = { distinct_clause: [], into_clause: Node.null, target_list: [], from_clause: [], where_clause: Node.null, group_clause: [], group_distinct: Bool.False, having_clause: Node.null, window_clause: [], values_lists: [], sort_clause: [], limit_offset: Node.null, limit_count: Node.null, limit_option: 0.I64, locking_clause: [], with_clause: Node.null, op: 0.I64, all: Bool.False, larg: Node.null, rarg: Node.null }

	select_stmt_of : Node -> Node.SelectStmt
	select_stmt_of = |n|
		match n {
			SelectStmt(r) => r
			_ => crash "expected SelectStmt, got ${Node.tag(n)}"
		}

	## `SetToDefault`
	SetToDefault : { type_id : I64, type_mod : I64, collation : I64, location : I64 }

	set_to_default_default : Node.SetToDefault
	set_to_default_default = { type_id: 0.I64, type_mod: 0.I64, collation: 0.I64, location: 0.I64 }

	set_to_default_of : Node -> Node.SetToDefault
	set_to_default_of = |n|
		match n {
			SetToDefault(r) => r
			_ => crash "expected SetToDefault, got ${Node.tag(n)}"
		}

	## `SortBy`
	SortBy : { node : Node, sortby_dir : I64, sortby_nulls : I64, use_op : List(Node), location : I64 }

	sort_by_default : Node.SortBy
	sort_by_default = { node: Node.null, sortby_dir: 0.I64, sortby_nulls: 0.I64, use_op: [], location: 0.I64 }

	sort_by_of : Node -> Node.SortBy
	sort_by_of = |n|
		match n {
			SortBy(r) => r
			_ => crash "expected SortBy, got ${Node.tag(n)}"
		}

	## `StatsElem`
	StatsElem : { name : Node.Text, expr : Node }

	stats_elem_default : Node.StatsElem
	stats_elem_default = { name: Err(Null), expr: Node.null }

	stats_elem_of : Node -> Node.StatsElem
	stats_elem_of = |n|
		match n {
			StatsElem(r) => r
			_ => crash "expected StatsElem, got ${Node.tag(n)}"
		}

	## `String`
	String : { sval : Node.Text }

	string_default : Node.String
	string_default = { sval: Err(Null) }

	string_of : Node -> Node.String
	string_of = |n|
		match n {
			String(r) => r
			_ => crash "expected String, got ${Node.tag(n)}"
		}

	## `SubLink`
	SubLink : { sub_link_type : I64, sub_link_id : I64, testexpr : Node, oper_name : List(Node), subselect : Node, location : I64 }

	sub_link_default : Node.SubLink
	sub_link_default = { sub_link_type: 0.I64, sub_link_id: 0.I64, testexpr: Node.null, oper_name: [], subselect: Node.null, location: 0.I64 }

	sub_link_of : Node -> Node.SubLink
	sub_link_of = |n|
		match n {
			SubLink(r) => r
			_ => crash "expected SubLink, got ${Node.tag(n)}"
		}

	## `TableLikeClause`
	TableLikeClause : { relation : Node, options : I64, relation_oid : I64 }

	table_like_clause_default : Node.TableLikeClause
	table_like_clause_default = { relation: Node.null, options: 0.I64, relation_oid: 0.I64 }

	table_like_clause_of : Node -> Node.TableLikeClause
	table_like_clause_of = |n|
		match n {
			TableLikeClause(r) => r
			_ => crash "expected TableLikeClause, got ${Node.tag(n)}"
		}

	## `TransactionStmt`
	TransactionStmt : { kind : I64, options : List(Node), savepoint_name : Node.Text, gid : Node.Text, chain : Bool, location : I64 }

	transaction_stmt_default : Node.TransactionStmt
	transaction_stmt_default = { kind: 0.I64, options: [], savepoint_name: Err(Null), gid: Err(Null), chain: Bool.False, location: 0.I64 }

	transaction_stmt_of : Node -> Node.TransactionStmt
	transaction_stmt_of = |n|
		match n {
			TransactionStmt(r) => r
			_ => crash "expected TransactionStmt, got ${Node.tag(n)}"
		}

	## `TriggerTransition`
	TriggerTransition : { name : Node.Text, is_new : Bool, is_table : Bool }

	trigger_transition_default : Node.TriggerTransition
	trigger_transition_default = { name: Err(Null), is_new: Bool.False, is_table: Bool.False }

	trigger_transition_of : Node -> Node.TriggerTransition
	trigger_transition_of = |n|
		match n {
			TriggerTransition(r) => r
			_ => crash "expected TriggerTransition, got ${Node.tag(n)}"
		}

	## `TruncateStmt`
	TruncateStmt : { relations : List(Node), restart_seqs : Bool, behavior : I64 }

	truncate_stmt_default : Node.TruncateStmt
	truncate_stmt_default = { relations: [], restart_seqs: Bool.False, behavior: 0.I64 }

	truncate_stmt_of : Node -> Node.TruncateStmt
	truncate_stmt_of = |n|
		match n {
			TruncateStmt(r) => r
			_ => crash "expected TruncateStmt, got ${Node.tag(n)}"
		}

	## `TypeCast`
	TypeCast : { arg : Node, type_name : Node, location : I64 }

	type_cast_default : Node.TypeCast
	type_cast_default = { arg: Node.null, type_name: Node.null, location: 0.I64 }

	type_cast_of : Node -> Node.TypeCast
	type_cast_of = |n|
		match n {
			TypeCast(r) => r
			_ => crash "expected TypeCast, got ${Node.tag(n)}"
		}

	## `TypeName`
	TypeName : { names : List(Node), type_oid : I64, setof : Bool, pct_type : Bool, typmods : List(Node), typemod : I64, array_bounds : List(Node), location : I64 }

	type_name_default : Node.TypeName
	type_name_default = { names: [], type_oid: 0.I64, setof: Bool.False, pct_type: Bool.False, typmods: [], typemod: 0.I64, array_bounds: [], location: 0.I64 }

	type_name_of : Node -> Node.TypeName
	type_name_of = |n|
		match n {
			TypeName(r) => r
			_ => crash "expected TypeName, got ${Node.tag(n)}"
		}

	## `UnlistenStmt`
	UnlistenStmt : { conditionname : Node.Text }

	unlisten_stmt_default : Node.UnlistenStmt
	unlisten_stmt_default = { conditionname: Err(Null) }

	unlisten_stmt_of : Node -> Node.UnlistenStmt
	unlisten_stmt_of = |n|
		match n {
			UnlistenStmt(r) => r
			_ => crash "expected UnlistenStmt, got ${Node.tag(n)}"
		}

	## `UpdateStmt`
	UpdateStmt : { relation : Node, target_list : List(Node), where_clause : Node, from_clause : List(Node), returning_clause : Node, with_clause : Node }

	update_stmt_default : Node.UpdateStmt
	update_stmt_default = { relation: Node.null, target_list: [], where_clause: Node.null, from_clause: [], returning_clause: Node.null, with_clause: Node.null }

	update_stmt_of : Node -> Node.UpdateStmt
	update_stmt_of = |n|
		match n {
			UpdateStmt(r) => r
			_ => crash "expected UpdateStmt, got ${Node.tag(n)}"
		}

	## `VacuumRelation`
	VacuumRelation : { relation : Node, oid : I64, va_cols : List(Node) }

	vacuum_relation_default : Node.VacuumRelation
	vacuum_relation_default = { relation: Node.null, oid: 0.I64, va_cols: [] }

	vacuum_relation_of : Node -> Node.VacuumRelation
	vacuum_relation_of = |n|
		match n {
			VacuumRelation(r) => r
			_ => crash "expected VacuumRelation, got ${Node.tag(n)}"
		}

	## `VacuumStmt`
	VacuumStmt : { options : List(Node), rels : List(Node), is_vacuumcmd : Bool }

	vacuum_stmt_default : Node.VacuumStmt
	vacuum_stmt_default = { options: [], rels: [], is_vacuumcmd: Bool.False }

	vacuum_stmt_of : Node -> Node.VacuumStmt
	vacuum_stmt_of = |n|
		match n {
			VacuumStmt(r) => r
			_ => crash "expected VacuumStmt, got ${Node.tag(n)}"
		}

	## `VariableSetStmt`
	VariableSetStmt : { kind : I64, name : Node.Text, args : List(Node), jumble_args : Bool, is_local : Bool, location : I64 }

	variable_set_stmt_default : Node.VariableSetStmt
	variable_set_stmt_default = { kind: 0.I64, name: Err(Null), args: [], jumble_args: Bool.False, is_local: Bool.False, location: 0.I64 }

	variable_set_stmt_of : Node -> Node.VariableSetStmt
	variable_set_stmt_of = |n|
		match n {
			VariableSetStmt(r) => r
			_ => crash "expected VariableSetStmt, got ${Node.tag(n)}"
		}

	## `VariableShowStmt`
	VariableShowStmt : { name : Node.Text }

	variable_show_stmt_default : Node.VariableShowStmt
	variable_show_stmt_default = { name: Err(Null) }

	variable_show_stmt_of : Node -> Node.VariableShowStmt
	variable_show_stmt_of = |n|
		match n {
			VariableShowStmt(r) => r
			_ => crash "expected VariableShowStmt, got ${Node.tag(n)}"
		}

	## `ViewStmt`
	ViewStmt : { view : Node, aliases : List(Node), query : Node, replace : Bool, options : List(Node), with_check_option : I64 }

	view_stmt_default : Node.ViewStmt
	view_stmt_default = { view: Node.null, aliases: [], query: Node.null, replace: Bool.False, options: [], with_check_option: 0.I64 }

	view_stmt_of : Node -> Node.ViewStmt
	view_stmt_of = |n|
		match n {
			ViewStmt(r) => r
			_ => crash "expected ViewStmt, got ${Node.tag(n)}"
		}

	## `WindowDef`
	WindowDef : { name : Node.Text, refname : Node.Text, partition_clause : List(Node), order_clause : List(Node), frame_options : I64, start_offset : Node, end_offset : Node, location : I64 }

	window_def_default : Node.WindowDef
	window_def_default = { name: Err(Null), refname: Err(Null), partition_clause: [], order_clause: [], frame_options: 0.I64, start_offset: Node.null, end_offset: Node.null, location: 0.I64 }

	window_def_of : Node -> Node.WindowDef
	window_def_of = |n|
		match n {
			WindowDef(r) => r
			_ => crash "expected WindowDef, got ${Node.tag(n)}"
		}

	## `WithClause`
	WithClause : { ctes : List(Node), recursive : Bool, location : I64 }

	with_clause_default : Node.WithClause
	with_clause_default = { ctes: [], recursive: Bool.False, location: 0.I64 }

	with_clause_of : Node -> Node.WithClause
	with_clause_of = |n|
		match n {
			WithClause(r) => r
			_ => crash "expected WithClause, got ${Node.tag(n)}"
		}

	## `XmlExpr`
	XmlExpr : { op : I64, name : Node.Text, named_args : List(Node), arg_names : List(Node), args : List(Node), xmloption : I64, indent : Bool, type : I64, typmod : I64, location : I64 }

	xml_expr_default : Node.XmlExpr
	xml_expr_default = { op: 0.I64, name: Err(Null), named_args: [], arg_names: [], args: [], xmloption: 0.I64, indent: Bool.False, type: 0.I64, typmod: 0.I64, location: 0.I64 }

	xml_expr_of : Node -> Node.XmlExpr
	xml_expr_of = |n|
		match n {
			XmlExpr(r) => r
			_ => crash "expected XmlExpr, got ${Node.tag(n)}"
		}

	## `XmlSerialize`
	XmlSerialize : { xmloption : I64, expr : Node, type_name : Node, indent : Bool, location : I64 }

	xml_serialize_default : Node.XmlSerialize
	xml_serialize_default = { xmloption: 0.I64, expr: Node.null, type_name: Node.null, indent: Bool.False, location: 0.I64 }

	xml_serialize_of : Node -> Node.XmlSerialize
	xml_serialize_of = |n|
		match n {
			XmlSerialize(r) => r
			_ => crash "expected XmlSerialize, got ${Node.tag(n)}"
		}

	## The node's type as named in C, such as `SelectStmt`, `List` for
	## a list, and the empty string for NULL.
	tag : Node -> Str
	tag = |n|
		match n {
			Null => ""
			NodeList(_) => "List"
			ATAlterConstraint(_) => "ATAlterConstraint"
			AArrayExpr(_) => "A_ArrayExpr"
			AConst(_) => "A_Const"
			AExpr(_) => "A_Expr"
			AIndices(_) => "A_Indices"
			AIndirection(_) => "A_Indirection"
			AStar(_) => "A_Star"
			AccessPriv(_) => "AccessPriv"
			Alias(_) => "Alias"
			AlterCollationStmt(_) => "AlterCollationStmt"
			AlterDatabaseRefreshCollStmt(_) => "AlterDatabaseRefreshCollStmt"
			AlterDatabaseSetStmt(_) => "AlterDatabaseSetStmt"
			AlterDatabaseStmt(_) => "AlterDatabaseStmt"
			AlterDefaultPrivilegesStmt(_) => "AlterDefaultPrivilegesStmt"
			AlterDomainStmt(_) => "AlterDomainStmt"
			AlterEnumStmt(_) => "AlterEnumStmt"
			AlterEventTrigStmt(_) => "AlterEventTrigStmt"
			AlterExtensionContentsStmt(_) => "AlterExtensionContentsStmt"
			AlterExtensionStmt(_) => "AlterExtensionStmt"
			AlterFdwStmt(_) => "AlterFdwStmt"
			AlterForeignServerStmt(_) => "AlterForeignServerStmt"
			AlterFunctionStmt(_) => "AlterFunctionStmt"
			AlterObjectDependsStmt(_) => "AlterObjectDependsStmt"
			AlterObjectSchemaStmt(_) => "AlterObjectSchemaStmt"
			AlterOpFamilyStmt(_) => "AlterOpFamilyStmt"
			AlterOperatorStmt(_) => "AlterOperatorStmt"
			AlterOwnerStmt(_) => "AlterOwnerStmt"
			AlterPolicyStmt(_) => "AlterPolicyStmt"
			AlterPublicationStmt(_) => "AlterPublicationStmt"
			AlterRoleSetStmt(_) => "AlterRoleSetStmt"
			AlterRoleStmt(_) => "AlterRoleStmt"
			AlterSeqStmt(_) => "AlterSeqStmt"
			AlterStatsStmt(_) => "AlterStatsStmt"
			AlterSubscriptionStmt(_) => "AlterSubscriptionStmt"
			AlterSystemStmt(_) => "AlterSystemStmt"
			AlterTSConfigurationStmt(_) => "AlterTSConfigurationStmt"
			AlterTSDictionaryStmt(_) => "AlterTSDictionaryStmt"
			AlterTableCmd(_) => "AlterTableCmd"
			AlterTableMoveAllStmt(_) => "AlterTableMoveAllStmt"
			AlterTableSpaceOptionsStmt(_) => "AlterTableSpaceOptionsStmt"
			AlterTableStmt(_) => "AlterTableStmt"
			AlterTypeStmt(_) => "AlterTypeStmt"
			AlterUserMappingStmt(_) => "AlterUserMappingStmt"
			BitString(_) => "BitString"
			BoolExpr(_) => "BoolExpr"
			Boolean(_) => "Boolean"
			BooleanTest(_) => "BooleanTest"
			CTECycleClause(_) => "CTECycleClause"
			CTESearchClause(_) => "CTESearchClause"
			CallStmt(_) => "CallStmt"
			CaseExpr(_) => "CaseExpr"
			CaseWhen(_) => "CaseWhen"
			CheckPointStmt(_) => "CheckPointStmt"
			ClosePortalStmt(_) => "ClosePortalStmt"
			ClusterStmt(_) => "ClusterStmt"
			CoalesceExpr(_) => "CoalesceExpr"
			CollateClause(_) => "CollateClause"
			ColumnDef(_) => "ColumnDef"
			ColumnRef(_) => "ColumnRef"
			CommentStmt(_) => "CommentStmt"
			CommonTableExpr(_) => "CommonTableExpr"
			CompositeTypeStmt(_) => "CompositeTypeStmt"
			Constraint(_) => "Constraint"
			ConstraintsSetStmt(_) => "ConstraintsSetStmt"
			CopyStmt(_) => "CopyStmt"
			CreateAmStmt(_) => "CreateAmStmt"
			CreateCastStmt(_) => "CreateCastStmt"
			CreateConversionStmt(_) => "CreateConversionStmt"
			CreateDomainStmt(_) => "CreateDomainStmt"
			CreateEnumStmt(_) => "CreateEnumStmt"
			CreateEventTrigStmt(_) => "CreateEventTrigStmt"
			CreateExtensionStmt(_) => "CreateExtensionStmt"
			CreateFdwStmt(_) => "CreateFdwStmt"
			CreateForeignServerStmt(_) => "CreateForeignServerStmt"
			CreateForeignTableStmt(_) => "CreateForeignTableStmt"
			CreateFunctionStmt(_) => "CreateFunctionStmt"
			CreateOpClassItem(_) => "CreateOpClassItem"
			CreateOpClassStmt(_) => "CreateOpClassStmt"
			CreateOpFamilyStmt(_) => "CreateOpFamilyStmt"
			CreatePLangStmt(_) => "CreatePLangStmt"
			CreatePolicyStmt(_) => "CreatePolicyStmt"
			CreatePublicationStmt(_) => "CreatePublicationStmt"
			CreateRangeStmt(_) => "CreateRangeStmt"
			CreateRoleStmt(_) => "CreateRoleStmt"
			CreateSchemaStmt(_) => "CreateSchemaStmt"
			CreateSeqStmt(_) => "CreateSeqStmt"
			CreateStatsStmt(_) => "CreateStatsStmt"
			CreateStmt(_) => "CreateStmt"
			CreateSubscriptionStmt(_) => "CreateSubscriptionStmt"
			CreateTableAsStmt(_) => "CreateTableAsStmt"
			CreateTableSpaceStmt(_) => "CreateTableSpaceStmt"
			CreateTransformStmt(_) => "CreateTransformStmt"
			CreateTrigStmt(_) => "CreateTrigStmt"
			CreateUserMappingStmt(_) => "CreateUserMappingStmt"
			CreatedbStmt(_) => "CreatedbStmt"
			CurrentOfExpr(_) => "CurrentOfExpr"
			DeallocateStmt(_) => "DeallocateStmt"
			DeclareCursorStmt(_) => "DeclareCursorStmt"
			DefElem(_) => "DefElem"
			DefineStmt(_) => "DefineStmt"
			DeleteStmt(_) => "DeleteStmt"
			DiscardStmt(_) => "DiscardStmt"
			DoStmt(_) => "DoStmt"
			DropOwnedStmt(_) => "DropOwnedStmt"
			DropRoleStmt(_) => "DropRoleStmt"
			DropStmt(_) => "DropStmt"
			DropSubscriptionStmt(_) => "DropSubscriptionStmt"
			DropTableSpaceStmt(_) => "DropTableSpaceStmt"
			DropUserMappingStmt(_) => "DropUserMappingStmt"
			DropdbStmt(_) => "DropdbStmt"
			ExecuteStmt(_) => "ExecuteStmt"
			ExplainStmt(_) => "ExplainStmt"
			FetchStmt(_) => "FetchStmt"
			Float(_) => "Float"
			FuncCall(_) => "FuncCall"
			FunctionParameter(_) => "FunctionParameter"
			GrantRoleStmt(_) => "GrantRoleStmt"
			GrantStmt(_) => "GrantStmt"
			GroupClause(_) => "GroupClause"
			GroupingFunc(_) => "GroupingFunc"
			GroupingSet(_) => "GroupingSet"
			ImportForeignSchemaStmt(_) => "ImportForeignSchemaStmt"
			ImportQual(_) => "ImportQual"
			IndexElem(_) => "IndexElem"
			IndexStmt(_) => "IndexStmt"
			InferClause(_) => "InferClause"
			InsertStmt(_) => "InsertStmt"
			Integer(_) => "Integer"
			IntoClause(_) => "IntoClause"
			JoinExpr(_) => "JoinExpr"
			JsonAggConstructor(_) => "JsonAggConstructor"
			JsonArgument(_) => "JsonArgument"
			JsonArrayAgg(_) => "JsonArrayAgg"
			JsonArrayConstructor(_) => "JsonArrayConstructor"
			JsonArrayQueryConstructor(_) => "JsonArrayQueryConstructor"
			JsonBehavior(_) => "JsonBehavior"
			JsonFormat(_) => "JsonFormat"
			JsonFuncExpr(_) => "JsonFuncExpr"
			JsonIsPredicate(_) => "JsonIsPredicate"
			JsonKeyValue(_) => "JsonKeyValue"
			JsonObjectAgg(_) => "JsonObjectAgg"
			JsonObjectConstructor(_) => "JsonObjectConstructor"
			JsonOutput(_) => "JsonOutput"
			JsonParseExpr(_) => "JsonParseExpr"
			JsonReturning(_) => "JsonReturning"
			JsonScalarExpr(_) => "JsonScalarExpr"
			JsonSerializeExpr(_) => "JsonSerializeExpr"
			JsonTable(_) => "JsonTable"
			JsonTableColumn(_) => "JsonTableColumn"
			JsonTablePathSpec(_) => "JsonTablePathSpec"
			JsonValueExpr(_) => "JsonValueExpr"
			KeyAction(_) => "KeyAction"
			KeyActions(_) => "KeyActions"
			ListenStmt(_) => "ListenStmt"
			LoadStmt(_) => "LoadStmt"
			LockStmt(_) => "LockStmt"
			LockingClause(_) => "LockingClause"
			MergeStmt(_) => "MergeStmt"
			MergeSupportFunc(_) => "MergeSupportFunc"
			MergeWhenClause(_) => "MergeWhenClause"
			MinMaxExpr(_) => "MinMaxExpr"
			MultiAssignRef(_) => "MultiAssignRef"
			NamedArgExpr(_) => "NamedArgExpr"
			NotifyStmt(_) => "NotifyStmt"
			NullTest(_) => "NullTest"
			ObjectWithArgs(_) => "ObjectWithArgs"
			OnConflictClause(_) => "OnConflictClause"
			PLAssignStmt(_) => "PLAssignStmt"
			ParamRef(_) => "ParamRef"
			PartitionBoundSpec(_) => "PartitionBoundSpec"
			PartitionCmd(_) => "PartitionCmd"
			PartitionElem(_) => "PartitionElem"
			PartitionSpec(_) => "PartitionSpec"
			PrepareStmt(_) => "PrepareStmt"
			PrivTarget(_) => "PrivTarget"
			PublicationObjSpec(_) => "PublicationObjSpec"
			PublicationTable(_) => "PublicationTable"
			RangeFunction(_) => "RangeFunction"
			RangeSubselect(_) => "RangeSubselect"
			RangeTableFunc(_) => "RangeTableFunc"
			RangeTableFuncCol(_) => "RangeTableFuncCol"
			RangeTableSample(_) => "RangeTableSample"
			RangeVar(_) => "RangeVar"
			RawStmt(_) => "RawStmt"
			ReassignOwnedStmt(_) => "ReassignOwnedStmt"
			RefreshMatViewStmt(_) => "RefreshMatViewStmt"
			ReindexStmt(_) => "ReindexStmt"
			RenameStmt(_) => "RenameStmt"
			ReplicaIdentityStmt(_) => "ReplicaIdentityStmt"
			ResTarget(_) => "ResTarget"
			ReturnStmt(_) => "ReturnStmt"
			ReturningClause(_) => "ReturningClause"
			ReturningOption(_) => "ReturningOption"
			RoleSpec(_) => "RoleSpec"
			RowExpr(_) => "RowExpr"
			RuleStmt(_) => "RuleStmt"
			SQLValueFunction(_) => "SQLValueFunction"
			SecLabelStmt(_) => "SecLabelStmt"
			SelectLimit(_) => "SelectLimit"
			SelectStmt(_) => "SelectStmt"
			SetToDefault(_) => "SetToDefault"
			SortBy(_) => "SortBy"
			StatsElem(_) => "StatsElem"
			String(_) => "String"
			SubLink(_) => "SubLink"
			TableLikeClause(_) => "TableLikeClause"
			TransactionStmt(_) => "TransactionStmt"
			TriggerTransition(_) => "TriggerTransition"
			TruncateStmt(_) => "TruncateStmt"
			TypeCast(_) => "TypeCast"
			TypeName(_) => "TypeName"
			UnlistenStmt(_) => "UnlistenStmt"
			UpdateStmt(_) => "UpdateStmt"
			VacuumRelation(_) => "VacuumRelation"
			VacuumStmt(_) => "VacuumStmt"
			VariableSetStmt(_) => "VariableSetStmt"
			VariableShowStmt(_) => "VariableShowStmt"
			ViewStmt(_) => "ViewStmt"
			WindowDef(_) => "WindowDef"
			WithClause(_) => "WithClause"
			XmlExpr(_) => "XmlExpr"
			XmlSerialize(_) => "XmlSerialize"
		}

	## Two trees alike, as Postgres's `equal` compares them.
	is_eq : Node, Node -> Bool
	is_eq = |a, b|
		match (a, b) {
			(Null, Null) => Bool.True
			(NodeList(x), NodeList(y)) => x == y
			(ATAlterConstraint(x), ATAlterConstraint(y)) => x == y
			(AArrayExpr(x), AArrayExpr(y)) => x == y
			(AConst(x), AConst(y)) => x == y
			(AExpr(x), AExpr(y)) => x == y
			(AIndices(x), AIndices(y)) => x == y
			(AIndirection(x), AIndirection(y)) => x == y
			(AStar(x), AStar(y)) => x == y
			(AccessPriv(x), AccessPriv(y)) => x == y
			(Alias(x), Alias(y)) => x == y
			(AlterCollationStmt(x), AlterCollationStmt(y)) => x == y
			(AlterDatabaseRefreshCollStmt(x), AlterDatabaseRefreshCollStmt(y)) => x == y
			(AlterDatabaseSetStmt(x), AlterDatabaseSetStmt(y)) => x == y
			(AlterDatabaseStmt(x), AlterDatabaseStmt(y)) => x == y
			(AlterDefaultPrivilegesStmt(x), AlterDefaultPrivilegesStmt(y)) => x == y
			(AlterDomainStmt(x), AlterDomainStmt(y)) => x == y
			(AlterEnumStmt(x), AlterEnumStmt(y)) => x == y
			(AlterEventTrigStmt(x), AlterEventTrigStmt(y)) => x == y
			(AlterExtensionContentsStmt(x), AlterExtensionContentsStmt(y)) => x == y
			(AlterExtensionStmt(x), AlterExtensionStmt(y)) => x == y
			(AlterFdwStmt(x), AlterFdwStmt(y)) => x == y
			(AlterForeignServerStmt(x), AlterForeignServerStmt(y)) => x == y
			(AlterFunctionStmt(x), AlterFunctionStmt(y)) => x == y
			(AlterObjectDependsStmt(x), AlterObjectDependsStmt(y)) => x == y
			(AlterObjectSchemaStmt(x), AlterObjectSchemaStmt(y)) => x == y
			(AlterOpFamilyStmt(x), AlterOpFamilyStmt(y)) => x == y
			(AlterOperatorStmt(x), AlterOperatorStmt(y)) => x == y
			(AlterOwnerStmt(x), AlterOwnerStmt(y)) => x == y
			(AlterPolicyStmt(x), AlterPolicyStmt(y)) => x == y
			(AlterPublicationStmt(x), AlterPublicationStmt(y)) => x == y
			(AlterRoleSetStmt(x), AlterRoleSetStmt(y)) => x == y
			(AlterRoleStmt(x), AlterRoleStmt(y)) => x == y
			(AlterSeqStmt(x), AlterSeqStmt(y)) => x == y
			(AlterStatsStmt(x), AlterStatsStmt(y)) => x == y
			(AlterSubscriptionStmt(x), AlterSubscriptionStmt(y)) => x == y
			(AlterSystemStmt(x), AlterSystemStmt(y)) => x == y
			(AlterTSConfigurationStmt(x), AlterTSConfigurationStmt(y)) => x == y
			(AlterTSDictionaryStmt(x), AlterTSDictionaryStmt(y)) => x == y
			(AlterTableCmd(x), AlterTableCmd(y)) => x == y
			(AlterTableMoveAllStmt(x), AlterTableMoveAllStmt(y)) => x == y
			(AlterTableSpaceOptionsStmt(x), AlterTableSpaceOptionsStmt(y)) => x == y
			(AlterTableStmt(x), AlterTableStmt(y)) => x == y
			(AlterTypeStmt(x), AlterTypeStmt(y)) => x == y
			(AlterUserMappingStmt(x), AlterUserMappingStmt(y)) => x == y
			(BitString(x), BitString(y)) => x == y
			(BoolExpr(x), BoolExpr(y)) => x == y
			(Boolean(x), Boolean(y)) => x == y
			(BooleanTest(x), BooleanTest(y)) => x == y
			(CTECycleClause(x), CTECycleClause(y)) => x == y
			(CTESearchClause(x), CTESearchClause(y)) => x == y
			(CallStmt(x), CallStmt(y)) => x == y
			(CaseExpr(x), CaseExpr(y)) => x == y
			(CaseWhen(x), CaseWhen(y)) => x == y
			(CheckPointStmt(x), CheckPointStmt(y)) => x == y
			(ClosePortalStmt(x), ClosePortalStmt(y)) => x == y
			(ClusterStmt(x), ClusterStmt(y)) => x == y
			(CoalesceExpr(x), CoalesceExpr(y)) => x == y
			(CollateClause(x), CollateClause(y)) => x == y
			(ColumnDef(x), ColumnDef(y)) => x == y
			(ColumnRef(x), ColumnRef(y)) => x == y
			(CommentStmt(x), CommentStmt(y)) => x == y
			(CommonTableExpr(x), CommonTableExpr(y)) => x == y
			(CompositeTypeStmt(x), CompositeTypeStmt(y)) => x == y
			(Constraint(x), Constraint(y)) => x == y
			(ConstraintsSetStmt(x), ConstraintsSetStmt(y)) => x == y
			(CopyStmt(x), CopyStmt(y)) => x == y
			(CreateAmStmt(x), CreateAmStmt(y)) => x == y
			(CreateCastStmt(x), CreateCastStmt(y)) => x == y
			(CreateConversionStmt(x), CreateConversionStmt(y)) => x == y
			(CreateDomainStmt(x), CreateDomainStmt(y)) => x == y
			(CreateEnumStmt(x), CreateEnumStmt(y)) => x == y
			(CreateEventTrigStmt(x), CreateEventTrigStmt(y)) => x == y
			(CreateExtensionStmt(x), CreateExtensionStmt(y)) => x == y
			(CreateFdwStmt(x), CreateFdwStmt(y)) => x == y
			(CreateForeignServerStmt(x), CreateForeignServerStmt(y)) => x == y
			(CreateForeignTableStmt(x), CreateForeignTableStmt(y)) => x == y
			(CreateFunctionStmt(x), CreateFunctionStmt(y)) => x == y
			(CreateOpClassItem(x), CreateOpClassItem(y)) => x == y
			(CreateOpClassStmt(x), CreateOpClassStmt(y)) => x == y
			(CreateOpFamilyStmt(x), CreateOpFamilyStmt(y)) => x == y
			(CreatePLangStmt(x), CreatePLangStmt(y)) => x == y
			(CreatePolicyStmt(x), CreatePolicyStmt(y)) => x == y
			(CreatePublicationStmt(x), CreatePublicationStmt(y)) => x == y
			(CreateRangeStmt(x), CreateRangeStmt(y)) => x == y
			(CreateRoleStmt(x), CreateRoleStmt(y)) => x == y
			(CreateSchemaStmt(x), CreateSchemaStmt(y)) => x == y
			(CreateSeqStmt(x), CreateSeqStmt(y)) => x == y
			(CreateStatsStmt(x), CreateStatsStmt(y)) => x == y
			(CreateStmt(x), CreateStmt(y)) => x == y
			(CreateSubscriptionStmt(x), CreateSubscriptionStmt(y)) => x == y
			(CreateTableAsStmt(x), CreateTableAsStmt(y)) => x == y
			(CreateTableSpaceStmt(x), CreateTableSpaceStmt(y)) => x == y
			(CreateTransformStmt(x), CreateTransformStmt(y)) => x == y
			(CreateTrigStmt(x), CreateTrigStmt(y)) => x == y
			(CreateUserMappingStmt(x), CreateUserMappingStmt(y)) => x == y
			(CreatedbStmt(x), CreatedbStmt(y)) => x == y
			(CurrentOfExpr(x), CurrentOfExpr(y)) => x == y
			(DeallocateStmt(x), DeallocateStmt(y)) => x == y
			(DeclareCursorStmt(x), DeclareCursorStmt(y)) => x == y
			(DefElem(x), DefElem(y)) => x == y
			(DefineStmt(x), DefineStmt(y)) => x == y
			(DeleteStmt(x), DeleteStmt(y)) => x == y
			(DiscardStmt(x), DiscardStmt(y)) => x == y
			(DoStmt(x), DoStmt(y)) => x == y
			(DropOwnedStmt(x), DropOwnedStmt(y)) => x == y
			(DropRoleStmt(x), DropRoleStmt(y)) => x == y
			(DropStmt(x), DropStmt(y)) => x == y
			(DropSubscriptionStmt(x), DropSubscriptionStmt(y)) => x == y
			(DropTableSpaceStmt(x), DropTableSpaceStmt(y)) => x == y
			(DropUserMappingStmt(x), DropUserMappingStmt(y)) => x == y
			(DropdbStmt(x), DropdbStmt(y)) => x == y
			(ExecuteStmt(x), ExecuteStmt(y)) => x == y
			(ExplainStmt(x), ExplainStmt(y)) => x == y
			(FetchStmt(x), FetchStmt(y)) => x == y
			(Float(x), Float(y)) => x == y
			(FuncCall(x), FuncCall(y)) => x == y
			(FunctionParameter(x), FunctionParameter(y)) => x == y
			(GrantRoleStmt(x), GrantRoleStmt(y)) => x == y
			(GrantStmt(x), GrantStmt(y)) => x == y
			(GroupClause(x), GroupClause(y)) => x == y
			(GroupingFunc(x), GroupingFunc(y)) => x == y
			(GroupingSet(x), GroupingSet(y)) => x == y
			(ImportForeignSchemaStmt(x), ImportForeignSchemaStmt(y)) => x == y
			(ImportQual(x), ImportQual(y)) => x == y
			(IndexElem(x), IndexElem(y)) => x == y
			(IndexStmt(x), IndexStmt(y)) => x == y
			(InferClause(x), InferClause(y)) => x == y
			(InsertStmt(x), InsertStmt(y)) => x == y
			(Integer(x), Integer(y)) => x == y
			(IntoClause(x), IntoClause(y)) => x == y
			(JoinExpr(x), JoinExpr(y)) => x == y
			(JsonAggConstructor(x), JsonAggConstructor(y)) => x == y
			(JsonArgument(x), JsonArgument(y)) => x == y
			(JsonArrayAgg(x), JsonArrayAgg(y)) => x == y
			(JsonArrayConstructor(x), JsonArrayConstructor(y)) => x == y
			(JsonArrayQueryConstructor(x), JsonArrayQueryConstructor(y)) => x == y
			(JsonBehavior(x), JsonBehavior(y)) => x == y
			(JsonFormat(x), JsonFormat(y)) => x == y
			(JsonFuncExpr(x), JsonFuncExpr(y)) => x == y
			(JsonIsPredicate(x), JsonIsPredicate(y)) => x == y
			(JsonKeyValue(x), JsonKeyValue(y)) => x == y
			(JsonObjectAgg(x), JsonObjectAgg(y)) => x == y
			(JsonObjectConstructor(x), JsonObjectConstructor(y)) => x == y
			(JsonOutput(x), JsonOutput(y)) => x == y
			(JsonParseExpr(x), JsonParseExpr(y)) => x == y
			(JsonReturning(x), JsonReturning(y)) => x == y
			(JsonScalarExpr(x), JsonScalarExpr(y)) => x == y
			(JsonSerializeExpr(x), JsonSerializeExpr(y)) => x == y
			(JsonTable(x), JsonTable(y)) => x == y
			(JsonTableColumn(x), JsonTableColumn(y)) => x == y
			(JsonTablePathSpec(x), JsonTablePathSpec(y)) => x == y
			(JsonValueExpr(x), JsonValueExpr(y)) => x == y
			(KeyAction(x), KeyAction(y)) => x == y
			(KeyActions(x), KeyActions(y)) => x == y
			(ListenStmt(x), ListenStmt(y)) => x == y
			(LoadStmt(x), LoadStmt(y)) => x == y
			(LockStmt(x), LockStmt(y)) => x == y
			(LockingClause(x), LockingClause(y)) => x == y
			(MergeStmt(x), MergeStmt(y)) => x == y
			(MergeSupportFunc(x), MergeSupportFunc(y)) => x == y
			(MergeWhenClause(x), MergeWhenClause(y)) => x == y
			(MinMaxExpr(x), MinMaxExpr(y)) => x == y
			(MultiAssignRef(x), MultiAssignRef(y)) => x == y
			(NamedArgExpr(x), NamedArgExpr(y)) => x == y
			(NotifyStmt(x), NotifyStmt(y)) => x == y
			(NullTest(x), NullTest(y)) => x == y
			(ObjectWithArgs(x), ObjectWithArgs(y)) => x == y
			(OnConflictClause(x), OnConflictClause(y)) => x == y
			(PLAssignStmt(x), PLAssignStmt(y)) => x == y
			(ParamRef(x), ParamRef(y)) => x == y
			(PartitionBoundSpec(x), PartitionBoundSpec(y)) => x == y
			(PartitionCmd(x), PartitionCmd(y)) => x == y
			(PartitionElem(x), PartitionElem(y)) => x == y
			(PartitionSpec(x), PartitionSpec(y)) => x == y
			(PrepareStmt(x), PrepareStmt(y)) => x == y
			(PrivTarget(x), PrivTarget(y)) => x == y
			(PublicationObjSpec(x), PublicationObjSpec(y)) => x == y
			(PublicationTable(x), PublicationTable(y)) => x == y
			(RangeFunction(x), RangeFunction(y)) => x == y
			(RangeSubselect(x), RangeSubselect(y)) => x == y
			(RangeTableFunc(x), RangeTableFunc(y)) => x == y
			(RangeTableFuncCol(x), RangeTableFuncCol(y)) => x == y
			(RangeTableSample(x), RangeTableSample(y)) => x == y
			(RangeVar(x), RangeVar(y)) => x == y
			(RawStmt(x), RawStmt(y)) => x == y
			(ReassignOwnedStmt(x), ReassignOwnedStmt(y)) => x == y
			(RefreshMatViewStmt(x), RefreshMatViewStmt(y)) => x == y
			(ReindexStmt(x), ReindexStmt(y)) => x == y
			(RenameStmt(x), RenameStmt(y)) => x == y
			(ReplicaIdentityStmt(x), ReplicaIdentityStmt(y)) => x == y
			(ResTarget(x), ResTarget(y)) => x == y
			(ReturnStmt(x), ReturnStmt(y)) => x == y
			(ReturningClause(x), ReturningClause(y)) => x == y
			(ReturningOption(x), ReturningOption(y)) => x == y
			(RoleSpec(x), RoleSpec(y)) => x == y
			(RowExpr(x), RowExpr(y)) => x == y
			(RuleStmt(x), RuleStmt(y)) => x == y
			(SQLValueFunction(x), SQLValueFunction(y)) => x == y
			(SecLabelStmt(x), SecLabelStmt(y)) => x == y
			(SelectLimit(x), SelectLimit(y)) => x == y
			(SelectStmt(x), SelectStmt(y)) => x == y
			(SetToDefault(x), SetToDefault(y)) => x == y
			(SortBy(x), SortBy(y)) => x == y
			(StatsElem(x), StatsElem(y)) => x == y
			(String(x), String(y)) => x == y
			(SubLink(x), SubLink(y)) => x == y
			(TableLikeClause(x), TableLikeClause(y)) => x == y
			(TransactionStmt(x), TransactionStmt(y)) => x == y
			(TriggerTransition(x), TriggerTransition(y)) => x == y
			(TruncateStmt(x), TruncateStmt(y)) => x == y
			(TypeCast(x), TypeCast(y)) => x == y
			(TypeName(x), TypeName(y)) => x == y
			(UnlistenStmt(x), UnlistenStmt(y)) => x == y
			(UpdateStmt(x), UpdateStmt(y)) => x == y
			(VacuumRelation(x), VacuumRelation(y)) => x == y
			(VacuumStmt(x), VacuumStmt(y)) => x == y
			(VariableSetStmt(x), VariableSetStmt(y)) => x == y
			(VariableShowStmt(x), VariableShowStmt(y)) => x == y
			(ViewStmt(x), ViewStmt(y)) => x == y
			(WindowDef(x), WindowDef(y)) => x == y
			(WithClause(x), WithClause(y)) => x == y
			(XmlExpr(x), XmlExpr(y)) => x == y
			(XmlSerialize(x), XmlSerialize(y)) => x == y
			_ => Bool.False
		}

	is_null : Node -> Bool
	is_null = |n|
		match n {
			Null => Bool.True
			_ => Bool.False
		}

	## Postgres's `equal`: two trees alike, not counting locations, how a
	## call was written (`CoercionForm`), and fields marked `equal_ignore`.
	equal : Node, Node -> Bool
	equal = |a, b|
		match (a, b) {
			(Null, Null) => Bool.True
			(Null, NodeList(y)) => y.is_empty()
			(NodeList(x), Null) => x.is_empty()
			(NodeList(x), NodeList(y)) => Node.list_equal(x, y)
			(ATAlterConstraint(x), ATAlterConstraint(y)) => x.conname == y.conname and x.alter_enforceability == y.alter_enforceability and x.is_enforced == y.is_enforced and x.alter_deferrability == y.alter_deferrability and x.deferrable == y.deferrable and x.initdeferred == y.initdeferred and x.alter_inheritability == y.alter_inheritability and x.noinherit == y.noinherit
			(AArrayExpr(x), AArrayExpr(y)) => Node.list_equal(x.elements, y.elements)
			(AConst(x), AConst(y)) => Node.equal(x.val, y.val) and x.isnull == y.isnull
			(AExpr(x), AExpr(y)) => x.kind == y.kind and Node.list_equal(x.name, y.name) and Node.equal(x.lexpr, y.lexpr) and Node.equal(x.rexpr, y.rexpr)
			(AIndices(x), AIndices(y)) => x.is_slice == y.is_slice and Node.equal(x.lidx, y.lidx) and Node.equal(x.uidx, y.uidx)
			(AIndirection(x), AIndirection(y)) => Node.equal(x.arg, y.arg) and Node.list_equal(x.indirection, y.indirection)
			(AStar(_), AStar(_)) => Bool.True
			(AccessPriv(x), AccessPriv(y)) => x.priv_name == y.priv_name and Node.list_equal(x.cols, y.cols)
			(Alias(x), Alias(y)) => x.aliasname == y.aliasname and Node.list_equal(x.colnames, y.colnames)
			(AlterCollationStmt(x), AlterCollationStmt(y)) => Node.list_equal(x.collname, y.collname)
			(AlterDatabaseRefreshCollStmt(x), AlterDatabaseRefreshCollStmt(y)) => x.dbname == y.dbname
			(AlterDatabaseSetStmt(x), AlterDatabaseSetStmt(y)) => x.dbname == y.dbname and Node.equal(x.setstmt, y.setstmt)
			(AlterDatabaseStmt(x), AlterDatabaseStmt(y)) => x.dbname == y.dbname and Node.list_equal(x.options, y.options)
			(AlterDefaultPrivilegesStmt(x), AlterDefaultPrivilegesStmt(y)) => Node.list_equal(x.options, y.options) and Node.equal(x.action, y.action)
			(AlterDomainStmt(x), AlterDomainStmt(y)) => x.subtype == y.subtype and Node.list_equal(x.type_name, y.type_name) and x.name == y.name and Node.equal(x.def, y.def) and x.behavior == y.behavior and x.missing_ok == y.missing_ok
			(AlterEnumStmt(x), AlterEnumStmt(y)) => Node.list_equal(x.type_name, y.type_name) and x.old_val == y.old_val and x.new_val == y.new_val and x.new_val_neighbor == y.new_val_neighbor and x.new_val_is_after == y.new_val_is_after and x.skip_if_new_val_exists == y.skip_if_new_val_exists
			(AlterEventTrigStmt(x), AlterEventTrigStmt(y)) => x.trigname == y.trigname and x.tgenabled == y.tgenabled
			(AlterExtensionContentsStmt(x), AlterExtensionContentsStmt(y)) => x.extname == y.extname and x.action == y.action and x.objtype == y.objtype and Node.equal(x.object, y.object)
			(AlterExtensionStmt(x), AlterExtensionStmt(y)) => x.extname == y.extname and Node.list_equal(x.options, y.options)
			(AlterFdwStmt(x), AlterFdwStmt(y)) => x.fdwname == y.fdwname and Node.list_equal(x.func_options, y.func_options) and Node.list_equal(x.options, y.options)
			(AlterForeignServerStmt(x), AlterForeignServerStmt(y)) => x.servername == y.servername and x.version == y.version and Node.list_equal(x.options, y.options) and x.has_version == y.has_version
			(AlterFunctionStmt(x), AlterFunctionStmt(y)) => x.objtype == y.objtype and Node.equal(x.func, y.func) and Node.list_equal(x.actions, y.actions)
			(AlterObjectDependsStmt(x), AlterObjectDependsStmt(y)) => x.object_type == y.object_type and Node.equal(x.relation, y.relation) and Node.equal(x.object, y.object) and Node.equal(x.extname, y.extname) and x.remove == y.remove
			(AlterObjectSchemaStmt(x), AlterObjectSchemaStmt(y)) => x.object_type == y.object_type and Node.equal(x.relation, y.relation) and Node.equal(x.object, y.object) and x.newschema == y.newschema and x.missing_ok == y.missing_ok
			(AlterOpFamilyStmt(x), AlterOpFamilyStmt(y)) => Node.list_equal(x.opfamilyname, y.opfamilyname) and x.amname == y.amname and x.is_drop == y.is_drop and Node.list_equal(x.items, y.items)
			(AlterOperatorStmt(x), AlterOperatorStmt(y)) => Node.equal(x.opername, y.opername) and Node.list_equal(x.options, y.options)
			(AlterOwnerStmt(x), AlterOwnerStmt(y)) => x.object_type == y.object_type and Node.equal(x.relation, y.relation) and Node.equal(x.object, y.object) and Node.equal(x.newowner, y.newowner)
			(AlterPolicyStmt(x), AlterPolicyStmt(y)) => x.policy_name == y.policy_name and Node.equal(x.table, y.table) and Node.list_equal(x.roles, y.roles) and Node.equal(x.qual, y.qual) and Node.equal(x.with_check, y.with_check)
			(AlterPublicationStmt(x), AlterPublicationStmt(y)) => x.pubname == y.pubname and Node.list_equal(x.options, y.options) and Node.list_equal(x.pubobjects, y.pubobjects) and x.for_all_tables == y.for_all_tables and x.action == y.action
			(AlterRoleSetStmt(x), AlterRoleSetStmt(y)) => Node.equal(x.role, y.role) and x.database == y.database and Node.equal(x.setstmt, y.setstmt)
			(AlterRoleStmt(x), AlterRoleStmt(y)) => Node.equal(x.role, y.role) and Node.list_equal(x.options, y.options) and x.action == y.action
			(AlterSeqStmt(x), AlterSeqStmt(y)) => Node.equal(x.sequence, y.sequence) and Node.list_equal(x.options, y.options) and x.for_identity == y.for_identity and x.missing_ok == y.missing_ok
			(AlterStatsStmt(x), AlterStatsStmt(y)) => Node.list_equal(x.defnames, y.defnames) and Node.equal(x.stxstattarget, y.stxstattarget) and x.missing_ok == y.missing_ok
			(AlterSubscriptionStmt(x), AlterSubscriptionStmt(y)) => x.kind == y.kind and x.subname == y.subname and x.conninfo == y.conninfo and Node.list_equal(x.publication, y.publication) and Node.list_equal(x.options, y.options)
			(AlterSystemStmt(x), AlterSystemStmt(y)) => Node.equal(x.setstmt, y.setstmt)
			(AlterTSConfigurationStmt(x), AlterTSConfigurationStmt(y)) => x.kind == y.kind and Node.list_equal(x.cfgname, y.cfgname) and Node.list_equal(x.tokentype, y.tokentype) and Node.list_equal(x.dicts, y.dicts) and x.override == y.override and x.replace == y.replace and x.missing_ok == y.missing_ok
			(AlterTSDictionaryStmt(x), AlterTSDictionaryStmt(y)) => Node.list_equal(x.dictname, y.dictname) and Node.list_equal(x.options, y.options)
			(AlterTableCmd(x), AlterTableCmd(y)) => x.subtype == y.subtype and x.name == y.name and x.num == y.num and Node.equal(x.newowner, y.newowner) and Node.equal(x.def, y.def) and x.behavior == y.behavior and x.missing_ok == y.missing_ok and x.recurse == y.recurse
			(AlterTableMoveAllStmt(x), AlterTableMoveAllStmt(y)) => x.orig_tablespacename == y.orig_tablespacename and x.objtype == y.objtype and Node.list_equal(x.roles, y.roles) and x.new_tablespacename == y.new_tablespacename and x.nowait == y.nowait
			(AlterTableSpaceOptionsStmt(x), AlterTableSpaceOptionsStmt(y)) => x.tablespacename == y.tablespacename and Node.list_equal(x.options, y.options) and x.is_reset == y.is_reset
			(AlterTableStmt(x), AlterTableStmt(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.cmds, y.cmds) and x.objtype == y.objtype and x.missing_ok == y.missing_ok
			(AlterTypeStmt(x), AlterTypeStmt(y)) => Node.list_equal(x.type_name, y.type_name) and Node.list_equal(x.options, y.options)
			(AlterUserMappingStmt(x), AlterUserMappingStmt(y)) => Node.equal(x.user, y.user) and x.servername == y.servername and Node.list_equal(x.options, y.options)
			(BitString(x), BitString(y)) => x.bsval == y.bsval
			(BoolExpr(x), BoolExpr(y)) => x.boolop == y.boolop and Node.list_equal(x.args, y.args)
			(Boolean(x), Boolean(y)) => x.boolval == y.boolval
			(BooleanTest(x), BooleanTest(y)) => Node.equal(x.arg, y.arg) and x.booltesttype == y.booltesttype
			(CTECycleClause(x), CTECycleClause(y)) => Node.list_equal(x.cycle_col_list, y.cycle_col_list) and x.cycle_mark_column == y.cycle_mark_column and Node.equal(x.cycle_mark_value, y.cycle_mark_value) and Node.equal(x.cycle_mark_default, y.cycle_mark_default) and x.cycle_path_column == y.cycle_path_column and x.cycle_mark_type == y.cycle_mark_type and x.cycle_mark_typmod == y.cycle_mark_typmod and x.cycle_mark_collation == y.cycle_mark_collation and x.cycle_mark_neop == y.cycle_mark_neop
			(CTESearchClause(x), CTESearchClause(y)) => Node.list_equal(x.search_col_list, y.search_col_list) and x.search_breadth_first == y.search_breadth_first and x.search_seq_column == y.search_seq_column
			(CallStmt(x), CallStmt(y)) => Node.equal(x.funccall, y.funccall) and Node.equal(x.funcexpr, y.funcexpr) and Node.list_equal(x.outargs, y.outargs)
			(CaseExpr(x), CaseExpr(y)) => x.casetype == y.casetype and x.casecollid == y.casecollid and Node.equal(x.arg, y.arg) and Node.list_equal(x.args, y.args) and Node.equal(x.defresult, y.defresult)
			(CaseWhen(x), CaseWhen(y)) => Node.equal(x.expr, y.expr) and Node.equal(x.result, y.result)
			(CheckPointStmt(_), CheckPointStmt(_)) => Bool.True
			(ClosePortalStmt(x), ClosePortalStmt(y)) => x.portalname == y.portalname
			(ClusterStmt(x), ClusterStmt(y)) => Node.equal(x.relation, y.relation) and x.indexname == y.indexname and Node.list_equal(x.params, y.params)
			(CoalesceExpr(x), CoalesceExpr(y)) => x.coalescetype == y.coalescetype and x.coalescecollid == y.coalescecollid and Node.list_equal(x.args, y.args)
			(CollateClause(x), CollateClause(y)) => Node.equal(x.arg, y.arg) and Node.list_equal(x.collname, y.collname)
			(ColumnDef(x), ColumnDef(y)) => x.colname == y.colname and Node.equal(x.type_name, y.type_name) and x.compression == y.compression and x.inhcount == y.inhcount and x.is_local == y.is_local and x.is_not_null == y.is_not_null and x.is_from_type == y.is_from_type and x.storage == y.storage and x.storage_name == y.storage_name and Node.equal(x.raw_default, y.raw_default) and Node.equal(x.cooked_default, y.cooked_default) and x.identity == y.identity and Node.equal(x.identity_sequence, y.identity_sequence) and x.generated == y.generated and Node.equal(x.coll_clause, y.coll_clause) and x.coll_oid == y.coll_oid and Node.list_equal(x.constraints, y.constraints) and Node.list_equal(x.fdwoptions, y.fdwoptions)
			(ColumnRef(x), ColumnRef(y)) => Node.list_equal(x.fields, y.fields)
			(CommentStmt(x), CommentStmt(y)) => x.objtype == y.objtype and Node.equal(x.object, y.object) and x.comment == y.comment
			(CommonTableExpr(x), CommonTableExpr(y)) => x.ctename == y.ctename and Node.list_equal(x.aliascolnames, y.aliascolnames) and x.ctematerialized == y.ctematerialized and Node.equal(x.ctequery, y.ctequery) and Node.equal(x.search_clause, y.search_clause) and Node.equal(x.cycle_clause, y.cycle_clause) and x.cterecursive == y.cterecursive and x.cterefcount == y.cterefcount and Node.list_equal(x.ctecolnames, y.ctecolnames) and Node.list_equal(x.ctecoltypes, y.ctecoltypes) and Node.list_equal(x.ctecoltypmods, y.ctecoltypmods) and Node.list_equal(x.ctecolcollations, y.ctecolcollations)
			(CompositeTypeStmt(x), CompositeTypeStmt(y)) => Node.equal(x.typevar, y.typevar) and Node.list_equal(x.coldeflist, y.coldeflist)
			(Constraint(x), Constraint(y)) => x.contype == y.contype and x.conname == y.conname and x.deferrable == y.deferrable and x.initdeferred == y.initdeferred and x.is_enforced == y.is_enforced and x.skip_validation == y.skip_validation and x.initially_valid == y.initially_valid and x.is_no_inherit == y.is_no_inherit and Node.equal(x.raw_expr, y.raw_expr) and x.cooked_expr == y.cooked_expr and x.generated_when == y.generated_when and x.generated_kind == y.generated_kind and x.nulls_not_distinct == y.nulls_not_distinct and Node.list_equal(x.keys, y.keys) and x.without_overlaps == y.without_overlaps and Node.list_equal(x.including, y.including) and Node.list_equal(x.exclusions, y.exclusions) and Node.list_equal(x.options, y.options) and x.indexname == y.indexname and x.indexspace == y.indexspace and x.reset_default_tblspc == y.reset_default_tblspc and x.access_method == y.access_method and Node.equal(x.where_clause, y.where_clause) and Node.equal(x.pktable, y.pktable) and Node.list_equal(x.fk_attrs, y.fk_attrs) and Node.list_equal(x.pk_attrs, y.pk_attrs) and x.fk_with_period == y.fk_with_period and x.pk_with_period == y.pk_with_period and x.fk_matchtype == y.fk_matchtype and x.fk_upd_action == y.fk_upd_action and x.fk_del_action == y.fk_del_action and Node.list_equal(x.fk_del_set_cols, y.fk_del_set_cols) and Node.list_equal(x.old_conpfeqop, y.old_conpfeqop) and x.old_pktable_oid == y.old_pktable_oid
			(ConstraintsSetStmt(x), ConstraintsSetStmt(y)) => Node.list_equal(x.constraints, y.constraints) and x.deferred == y.deferred
			(CopyStmt(x), CopyStmt(y)) => Node.equal(x.relation, y.relation) and Node.equal(x.query, y.query) and Node.list_equal(x.attlist, y.attlist) and x.is_from == y.is_from and x.is_program == y.is_program and x.filename == y.filename and Node.list_equal(x.options, y.options) and Node.equal(x.where_clause, y.where_clause)
			(CreateAmStmt(x), CreateAmStmt(y)) => x.amname == y.amname and Node.list_equal(x.handler_name, y.handler_name) and x.amtype == y.amtype
			(CreateCastStmt(x), CreateCastStmt(y)) => Node.equal(x.sourcetype, y.sourcetype) and Node.equal(x.targettype, y.targettype) and Node.equal(x.func, y.func) and x.context == y.context and x.inout == y.inout
			(CreateConversionStmt(x), CreateConversionStmt(y)) => Node.list_equal(x.conversion_name, y.conversion_name) and x.for_encoding_name == y.for_encoding_name and x.to_encoding_name == y.to_encoding_name and Node.list_equal(x.func_name, y.func_name) and x.def == y.def
			(CreateDomainStmt(x), CreateDomainStmt(y)) => Node.list_equal(x.domainname, y.domainname) and Node.equal(x.type_name, y.type_name) and Node.equal(x.coll_clause, y.coll_clause) and Node.list_equal(x.constraints, y.constraints)
			(CreateEnumStmt(x), CreateEnumStmt(y)) => Node.list_equal(x.type_name, y.type_name) and Node.list_equal(x.vals, y.vals)
			(CreateEventTrigStmt(x), CreateEventTrigStmt(y)) => x.trigname == y.trigname and x.eventname == y.eventname and Node.list_equal(x.whenclause, y.whenclause) and Node.list_equal(x.funcname, y.funcname)
			(CreateExtensionStmt(x), CreateExtensionStmt(y)) => x.extname == y.extname and x.if_not_exists == y.if_not_exists and Node.list_equal(x.options, y.options)
			(CreateFdwStmt(x), CreateFdwStmt(y)) => x.fdwname == y.fdwname and Node.list_equal(x.func_options, y.func_options) and Node.list_equal(x.options, y.options)
			(CreateForeignServerStmt(x), CreateForeignServerStmt(y)) => x.servername == y.servername and x.servertype == y.servertype and x.version == y.version and x.fdwname == y.fdwname and x.if_not_exists == y.if_not_exists and Node.list_equal(x.options, y.options)
			(CreateForeignTableStmt(x), CreateForeignTableStmt(y)) => Node.equal(x.base, y.base) and x.servername == y.servername and Node.list_equal(x.options, y.options)
			(CreateFunctionStmt(x), CreateFunctionStmt(y)) => x.is_procedure == y.is_procedure and x.replace == y.replace and Node.list_equal(x.funcname, y.funcname) and Node.list_equal(x.parameters, y.parameters) and Node.equal(x.return_type, y.return_type) and Node.list_equal(x.options, y.options) and Node.equal(x.sql_body, y.sql_body)
			(CreateOpClassItem(x), CreateOpClassItem(y)) => x.itemtype == y.itemtype and Node.equal(x.name, y.name) and x.number == y.number and Node.list_equal(x.order_family, y.order_family) and Node.list_equal(x.class_args, y.class_args) and Node.equal(x.storedtype, y.storedtype)
			(CreateOpClassStmt(x), CreateOpClassStmt(y)) => Node.list_equal(x.opclassname, y.opclassname) and Node.list_equal(x.opfamilyname, y.opfamilyname) and x.amname == y.amname and Node.equal(x.datatype, y.datatype) and Node.list_equal(x.items, y.items) and x.is_default == y.is_default
			(CreateOpFamilyStmt(x), CreateOpFamilyStmt(y)) => Node.list_equal(x.opfamilyname, y.opfamilyname) and x.amname == y.amname
			(CreatePLangStmt(x), CreatePLangStmt(y)) => x.replace == y.replace and x.plname == y.plname and Node.list_equal(x.plhandler, y.plhandler) and Node.list_equal(x.plinline, y.plinline) and Node.list_equal(x.plvalidator, y.plvalidator) and x.pltrusted == y.pltrusted
			(CreatePolicyStmt(x), CreatePolicyStmt(y)) => x.policy_name == y.policy_name and Node.equal(x.table, y.table) and x.cmd_name == y.cmd_name and x.permissive == y.permissive and Node.list_equal(x.roles, y.roles) and Node.equal(x.qual, y.qual) and Node.equal(x.with_check, y.with_check)
			(CreatePublicationStmt(x), CreatePublicationStmt(y)) => x.pubname == y.pubname and Node.list_equal(x.options, y.options) and Node.list_equal(x.pubobjects, y.pubobjects) and x.for_all_tables == y.for_all_tables
			(CreateRangeStmt(x), CreateRangeStmt(y)) => Node.list_equal(x.type_name, y.type_name) and Node.list_equal(x.params, y.params)
			(CreateRoleStmt(x), CreateRoleStmt(y)) => x.stmt_type == y.stmt_type and x.role == y.role and Node.list_equal(x.options, y.options)
			(CreateSchemaStmt(x), CreateSchemaStmt(y)) => x.schemaname == y.schemaname and Node.equal(x.authrole, y.authrole) and Node.list_equal(x.schema_elts, y.schema_elts) and x.if_not_exists == y.if_not_exists
			(CreateSeqStmt(x), CreateSeqStmt(y)) => Node.equal(x.sequence, y.sequence) and Node.list_equal(x.options, y.options) and x.owner_id == y.owner_id and x.for_identity == y.for_identity and x.if_not_exists == y.if_not_exists
			(CreateStatsStmt(x), CreateStatsStmt(y)) => Node.list_equal(x.defnames, y.defnames) and Node.list_equal(x.stat_types, y.stat_types) and Node.list_equal(x.exprs, y.exprs) and Node.list_equal(x.relations, y.relations) and x.stxcomment == y.stxcomment and x.transformed == y.transformed and x.if_not_exists == y.if_not_exists and x.owner == y.owner
			(CreateStmt(x), CreateStmt(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.table_elts, y.table_elts) and Node.list_equal(x.inh_relations, y.inh_relations) and Node.equal(x.partbound, y.partbound) and Node.equal(x.partspec, y.partspec) and Node.equal(x.of_typename, y.of_typename) and Node.list_equal(x.constraints, y.constraints) and Node.list_equal(x.nnconstraints, y.nnconstraints) and Node.list_equal(x.options, y.options) and x.oncommit == y.oncommit and x.tablespacename == y.tablespacename and x.access_method == y.access_method and x.if_not_exists == y.if_not_exists
			(CreateSubscriptionStmt(x), CreateSubscriptionStmt(y)) => x.subname == y.subname and x.conninfo == y.conninfo and Node.list_equal(x.publication, y.publication) and Node.list_equal(x.options, y.options)
			(CreateTableAsStmt(x), CreateTableAsStmt(y)) => Node.equal(x.query, y.query) and Node.equal(x.into, y.into) and x.objtype == y.objtype and x.is_select_into == y.is_select_into and x.if_not_exists == y.if_not_exists
			(CreateTableSpaceStmt(x), CreateTableSpaceStmt(y)) => x.tablespacename == y.tablespacename and Node.equal(x.owner, y.owner) and x.location == y.location and Node.list_equal(x.options, y.options)
			(CreateTransformStmt(x), CreateTransformStmt(y)) => x.replace == y.replace and Node.equal(x.type_name, y.type_name) and x.lang == y.lang and Node.equal(x.fromsql, y.fromsql) and Node.equal(x.tosql, y.tosql)
			(CreateTrigStmt(x), CreateTrigStmt(y)) => x.replace == y.replace and x.isconstraint == y.isconstraint and x.trigname == y.trigname and Node.equal(x.relation, y.relation) and Node.list_equal(x.funcname, y.funcname) and Node.list_equal(x.args, y.args) and x.row == y.row and x.timing == y.timing and x.events == y.events and Node.list_equal(x.columns, y.columns) and Node.equal(x.when_clause, y.when_clause) and Node.list_equal(x.transition_rels, y.transition_rels) and x.deferrable == y.deferrable and x.initdeferred == y.initdeferred and Node.equal(x.constrrel, y.constrrel)
			(CreateUserMappingStmt(x), CreateUserMappingStmt(y)) => Node.equal(x.user, y.user) and x.servername == y.servername and x.if_not_exists == y.if_not_exists and Node.list_equal(x.options, y.options)
			(CreatedbStmt(x), CreatedbStmt(y)) => x.dbname == y.dbname and Node.list_equal(x.options, y.options)
			(CurrentOfExpr(x), CurrentOfExpr(y)) => x.cvarno == y.cvarno and x.cursor_name == y.cursor_name and x.cursor_param == y.cursor_param
			(DeallocateStmt(x), DeallocateStmt(y)) => x.name == y.name and x.isall == y.isall
			(DeclareCursorStmt(x), DeclareCursorStmt(y)) => x.portalname == y.portalname and x.options == y.options and Node.equal(x.query, y.query)
			(DefElem(x), DefElem(y)) => x.defnamespace == y.defnamespace and x.defname == y.defname and Node.equal(x.arg, y.arg) and x.defaction == y.defaction
			(DefineStmt(x), DefineStmt(y)) => x.kind == y.kind and x.oldstyle == y.oldstyle and Node.list_equal(x.defnames, y.defnames) and Node.list_equal(x.args, y.args) and Node.list_equal(x.definition, y.definition) and x.if_not_exists == y.if_not_exists and x.replace == y.replace
			(DeleteStmt(x), DeleteStmt(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.using_clause, y.using_clause) and Node.equal(x.where_clause, y.where_clause) and Node.equal(x.returning_clause, y.returning_clause) and Node.equal(x.with_clause, y.with_clause)
			(DiscardStmt(x), DiscardStmt(y)) => x.target == y.target
			(DoStmt(x), DoStmt(y)) => Node.list_equal(x.args, y.args)
			(DropOwnedStmt(x), DropOwnedStmt(y)) => Node.list_equal(x.roles, y.roles) and x.behavior == y.behavior
			(DropRoleStmt(x), DropRoleStmt(y)) => Node.list_equal(x.roles, y.roles) and x.missing_ok == y.missing_ok
			(DropStmt(x), DropStmt(y)) => Node.list_equal(x.objects, y.objects) and x.remove_type == y.remove_type and x.behavior == y.behavior and x.missing_ok == y.missing_ok and x.concurrent == y.concurrent
			(DropSubscriptionStmt(x), DropSubscriptionStmt(y)) => x.subname == y.subname and x.missing_ok == y.missing_ok and x.behavior == y.behavior
			(DropTableSpaceStmt(x), DropTableSpaceStmt(y)) => x.tablespacename == y.tablespacename and x.missing_ok == y.missing_ok
			(DropUserMappingStmt(x), DropUserMappingStmt(y)) => Node.equal(x.user, y.user) and x.servername == y.servername and x.missing_ok == y.missing_ok
			(DropdbStmt(x), DropdbStmt(y)) => x.dbname == y.dbname and x.missing_ok == y.missing_ok and Node.list_equal(x.options, y.options)
			(ExecuteStmt(x), ExecuteStmt(y)) => x.name == y.name and Node.list_equal(x.params, y.params)
			(ExplainStmt(x), ExplainStmt(y)) => Node.equal(x.query, y.query) and Node.list_equal(x.options, y.options)
			(FetchStmt(x), FetchStmt(y)) => x.direction == y.direction and x.how_many == y.how_many and x.portalname == y.portalname and x.ismove == y.ismove
			(Float(x), Float(y)) => x.fval == y.fval
			(FuncCall(x), FuncCall(y)) => Node.list_equal(x.funcname, y.funcname) and Node.list_equal(x.args, y.args) and Node.list_equal(x.agg_order, y.agg_order) and Node.equal(x.agg_filter, y.agg_filter) and Node.equal(x.over, y.over) and x.agg_within_group == y.agg_within_group and x.agg_star == y.agg_star and x.agg_distinct == y.agg_distinct and x.func_variadic == y.func_variadic
			(FunctionParameter(x), FunctionParameter(y)) => x.name == y.name and Node.equal(x.arg_type, y.arg_type) and x.mode == y.mode and Node.equal(x.defexpr, y.defexpr)
			(GrantRoleStmt(x), GrantRoleStmt(y)) => Node.list_equal(x.granted_roles, y.granted_roles) and Node.list_equal(x.grantee_roles, y.grantee_roles) and x.is_grant == y.is_grant and Node.list_equal(x.opt, y.opt) and Node.equal(x.grantor, y.grantor) and x.behavior == y.behavior
			(GrantStmt(x), GrantStmt(y)) => x.is_grant == y.is_grant and x.targtype == y.targtype and x.objtype == y.objtype and Node.list_equal(x.objects, y.objects) and Node.list_equal(x.privileges, y.privileges) and Node.list_equal(x.grantees, y.grantees) and x.grant_option == y.grant_option and Node.equal(x.grantor, y.grantor) and x.behavior == y.behavior
			(GroupClause(x), GroupClause(y)) => x.distinct == y.distinct and Node.list_equal(x.list, y.list)
			(GroupingFunc(x), GroupingFunc(y)) => Node.list_equal(x.args, y.args) and x.agglevelsup == y.agglevelsup
			(GroupingSet(x), GroupingSet(y)) => x.kind == y.kind and Node.list_equal(x.content, y.content)
			(ImportForeignSchemaStmt(x), ImportForeignSchemaStmt(y)) => x.server_name == y.server_name and x.remote_schema == y.remote_schema and x.local_schema == y.local_schema and x.list_type == y.list_type and Node.list_equal(x.table_list, y.table_list) and Node.list_equal(x.options, y.options)
			(ImportQual(x), ImportQual(y)) => x.type == y.type and Node.list_equal(x.table_names, y.table_names)
			(IndexElem(x), IndexElem(y)) => x.name == y.name and Node.equal(x.expr, y.expr) and x.indexcolname == y.indexcolname and Node.list_equal(x.collation, y.collation) and Node.list_equal(x.opclass, y.opclass) and Node.list_equal(x.opclassopts, y.opclassopts) and x.ordering == y.ordering and x.nulls_ordering == y.nulls_ordering
			(IndexStmt(x), IndexStmt(y)) => x.idxname == y.idxname and Node.equal(x.relation, y.relation) and x.access_method == y.access_method and x.table_space == y.table_space and Node.list_equal(x.index_params, y.index_params) and Node.list_equal(x.index_including_params, y.index_including_params) and Node.list_equal(x.options, y.options) and Node.equal(x.where_clause, y.where_clause) and Node.list_equal(x.exclude_op_names, y.exclude_op_names) and x.idxcomment == y.idxcomment and x.index_oid == y.index_oid and x.old_number == y.old_number and x.old_create_subid == y.old_create_subid and x.old_first_relfilelocator_subid == y.old_first_relfilelocator_subid and x.unique == y.unique and x.nulls_not_distinct == y.nulls_not_distinct and x.primary == y.primary and x.isconstraint == y.isconstraint and x.iswithoutoverlaps == y.iswithoutoverlaps and x.deferrable == y.deferrable and x.initdeferred == y.initdeferred and x.transformed == y.transformed and x.concurrent == y.concurrent and x.if_not_exists == y.if_not_exists and x.reset_default_tblspc == y.reset_default_tblspc
			(InferClause(x), InferClause(y)) => Node.list_equal(x.index_elems, y.index_elems) and Node.equal(x.where_clause, y.where_clause) and x.conname == y.conname
			(InsertStmt(x), InsertStmt(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.cols, y.cols) and Node.equal(x.select_stmt, y.select_stmt) and Node.equal(x.on_conflict_clause, y.on_conflict_clause) and Node.equal(x.returning_clause, y.returning_clause) and Node.equal(x.with_clause, y.with_clause) and x.override == y.override
			(Integer(x), Integer(y)) => x.ival == y.ival
			(IntoClause(x), IntoClause(y)) => Node.equal(x.rel, y.rel) and Node.list_equal(x.col_names, y.col_names) and x.access_method == y.access_method and Node.list_equal(x.options, y.options) and x.on_commit == y.on_commit and x.table_space_name == y.table_space_name and Node.equal(x.view_query, y.view_query) and x.skip_data == y.skip_data
			(JoinExpr(x), JoinExpr(y)) => x.jointype == y.jointype and x.is_natural == y.is_natural and Node.equal(x.larg, y.larg) and Node.equal(x.rarg, y.rarg) and Node.list_equal(x.using_clause, y.using_clause) and Node.equal(x.join_using_alias, y.join_using_alias) and Node.equal(x.quals, y.quals) and Node.equal(x.alias, y.alias) and x.rtindex == y.rtindex
			(JsonAggConstructor(x), JsonAggConstructor(y)) => Node.equal(x.output, y.output) and Node.equal(x.agg_filter, y.agg_filter) and Node.list_equal(x.agg_order, y.agg_order) and Node.equal(x.over, y.over)
			(JsonArgument(x), JsonArgument(y)) => Node.equal(x.val, y.val) and x.name == y.name
			(JsonArrayAgg(x), JsonArrayAgg(y)) => Node.equal(x.constructor, y.constructor) and Node.equal(x.arg, y.arg) and x.absent_on_null == y.absent_on_null
			(JsonArrayConstructor(x), JsonArrayConstructor(y)) => Node.list_equal(x.exprs, y.exprs) and Node.equal(x.output, y.output) and x.absent_on_null == y.absent_on_null
			(JsonArrayQueryConstructor(x), JsonArrayQueryConstructor(y)) => Node.equal(x.query, y.query) and Node.equal(x.output, y.output) and Node.equal(x.format, y.format) and x.absent_on_null == y.absent_on_null
			(JsonBehavior(x), JsonBehavior(y)) => x.btype == y.btype and Node.equal(x.expr, y.expr) and x.coerce == y.coerce
			(JsonFormat(x), JsonFormat(y)) => x.format_type == y.format_type and x.encoding == y.encoding
			(JsonFuncExpr(x), JsonFuncExpr(y)) => x.op == y.op and x.column_name == y.column_name and Node.equal(x.context_item, y.context_item) and Node.equal(x.pathspec, y.pathspec) and Node.list_equal(x.passing, y.passing) and Node.equal(x.output, y.output) and Node.equal(x.on_empty, y.on_empty) and Node.equal(x.on_error, y.on_error) and x.wrapper == y.wrapper and x.quotes == y.quotes
			(JsonIsPredicate(x), JsonIsPredicate(y)) => Node.equal(x.expr, y.expr) and Node.equal(x.format, y.format) and x.item_type == y.item_type and x.unique_keys == y.unique_keys
			(JsonKeyValue(x), JsonKeyValue(y)) => Node.equal(x.key, y.key) and Node.equal(x.value, y.value)
			(JsonObjectAgg(x), JsonObjectAgg(y)) => Node.equal(x.constructor, y.constructor) and Node.equal(x.arg, y.arg) and x.absent_on_null == y.absent_on_null and x.unique == y.unique
			(JsonObjectConstructor(x), JsonObjectConstructor(y)) => Node.list_equal(x.exprs, y.exprs) and Node.equal(x.output, y.output) and x.absent_on_null == y.absent_on_null and x.unique == y.unique
			(JsonOutput(x), JsonOutput(y)) => Node.equal(x.type_name, y.type_name) and Node.equal(x.returning, y.returning)
			(JsonParseExpr(x), JsonParseExpr(y)) => Node.equal(x.expr, y.expr) and Node.equal(x.output, y.output) and x.unique_keys == y.unique_keys
			(JsonReturning(x), JsonReturning(y)) => Node.equal(x.format, y.format) and x.typid == y.typid and x.typmod == y.typmod
			(JsonScalarExpr(x), JsonScalarExpr(y)) => Node.equal(x.expr, y.expr) and Node.equal(x.output, y.output)
			(JsonSerializeExpr(x), JsonSerializeExpr(y)) => Node.equal(x.expr, y.expr) and Node.equal(x.output, y.output)
			(JsonTable(x), JsonTable(y)) => Node.equal(x.context_item, y.context_item) and Node.equal(x.pathspec, y.pathspec) and Node.list_equal(x.passing, y.passing) and Node.list_equal(x.columns, y.columns) and Node.equal(x.on_error, y.on_error) and Node.equal(x.alias, y.alias) and x.lateral == y.lateral
			(JsonTableColumn(x), JsonTableColumn(y)) => x.coltype == y.coltype and x.name == y.name and Node.equal(x.type_name, y.type_name) and Node.equal(x.pathspec, y.pathspec) and Node.equal(x.format, y.format) and x.wrapper == y.wrapper and x.quotes == y.quotes and Node.list_equal(x.columns, y.columns) and Node.equal(x.on_empty, y.on_empty) and Node.equal(x.on_error, y.on_error)
			(JsonTablePathSpec(x), JsonTablePathSpec(y)) => Node.equal(x.string, y.string) and x.name == y.name
			(JsonValueExpr(x), JsonValueExpr(y)) => Node.equal(x.raw_expr, y.raw_expr) and Node.equal(x.formatted_expr, y.formatted_expr) and Node.equal(x.format, y.format)
			(KeyAction(x), KeyAction(y)) => x.action == y.action and Node.list_equal(x.cols, y.cols)
			(KeyActions(x), KeyActions(y)) => Node.equal(x.update_action, y.update_action) and Node.equal(x.delete_action, y.delete_action)
			(ListenStmt(x), ListenStmt(y)) => x.conditionname == y.conditionname
			(LoadStmt(x), LoadStmt(y)) => x.filename == y.filename
			(LockStmt(x), LockStmt(y)) => Node.list_equal(x.relations, y.relations) and x.mode == y.mode and x.nowait == y.nowait
			(LockingClause(x), LockingClause(y)) => Node.list_equal(x.locked_rels, y.locked_rels) and x.strength == y.strength and x.wait_policy == y.wait_policy
			(MergeStmt(x), MergeStmt(y)) => Node.equal(x.relation, y.relation) and Node.equal(x.source_relation, y.source_relation) and Node.equal(x.join_condition, y.join_condition) and Node.list_equal(x.merge_when_clauses, y.merge_when_clauses) and Node.equal(x.returning_clause, y.returning_clause) and Node.equal(x.with_clause, y.with_clause)
			(MergeSupportFunc(x), MergeSupportFunc(y)) => x.msftype == y.msftype and x.msfcollid == y.msfcollid
			(MergeWhenClause(x), MergeWhenClause(y)) => x.match_kind == y.match_kind and x.command_type == y.command_type and x.override == y.override and Node.equal(x.condition, y.condition) and Node.list_equal(x.target_list, y.target_list) and Node.list_equal(x.values, y.values)
			(MinMaxExpr(x), MinMaxExpr(y)) => x.minmaxtype == y.minmaxtype and x.minmaxcollid == y.minmaxcollid and x.inputcollid == y.inputcollid and x.op == y.op and Node.list_equal(x.args, y.args)
			(MultiAssignRef(x), MultiAssignRef(y)) => Node.equal(x.source, y.source) and x.colno == y.colno and x.ncolumns == y.ncolumns
			(NamedArgExpr(x), NamedArgExpr(y)) => Node.equal(x.arg, y.arg) and x.name == y.name and x.argnumber == y.argnumber
			(NotifyStmt(x), NotifyStmt(y)) => x.conditionname == y.conditionname and x.payload == y.payload
			(NullTest(x), NullTest(y)) => Node.equal(x.arg, y.arg) and x.nulltesttype == y.nulltesttype and x.argisrow == y.argisrow
			(ObjectWithArgs(x), ObjectWithArgs(y)) => Node.list_equal(x.objname, y.objname) and Node.list_equal(x.objargs, y.objargs) and Node.list_equal(x.objfuncargs, y.objfuncargs) and x.args_unspecified == y.args_unspecified
			(OnConflictClause(x), OnConflictClause(y)) => x.action == y.action and Node.equal(x.infer, y.infer) and Node.list_equal(x.target_list, y.target_list) and Node.equal(x.where_clause, y.where_clause)
			(PLAssignStmt(x), PLAssignStmt(y)) => x.name == y.name and Node.list_equal(x.indirection, y.indirection) and x.nnames == y.nnames and Node.equal(x.val, y.val)
			(ParamRef(x), ParamRef(y)) => x.number == y.number
			(PartitionBoundSpec(x), PartitionBoundSpec(y)) => x.strategy == y.strategy and x.is_default == y.is_default and x.modulus == y.modulus and x.remainder == y.remainder and Node.list_equal(x.listdatums, y.listdatums) and Node.list_equal(x.lowerdatums, y.lowerdatums) and Node.list_equal(x.upperdatums, y.upperdatums)
			(PartitionCmd(x), PartitionCmd(y)) => Node.equal(x.name, y.name) and Node.equal(x.bound, y.bound) and x.concurrent == y.concurrent
			(PartitionElem(x), PartitionElem(y)) => x.name == y.name and Node.equal(x.expr, y.expr) and Node.list_equal(x.collation, y.collation) and Node.list_equal(x.opclass, y.opclass)
			(PartitionSpec(x), PartitionSpec(y)) => x.strategy == y.strategy and Node.list_equal(x.part_params, y.part_params)
			(PrepareStmt(x), PrepareStmt(y)) => x.name == y.name and Node.list_equal(x.argtypes, y.argtypes) and Node.equal(x.query, y.query)
			(PrivTarget(x), PrivTarget(y)) => x.targtype == y.targtype and x.objtype == y.objtype and Node.list_equal(x.objs, y.objs)
			(PublicationObjSpec(x), PublicationObjSpec(y)) => x.pubobjtype == y.pubobjtype and x.name == y.name and Node.equal(x.pubtable, y.pubtable)
			(PublicationTable(x), PublicationTable(y)) => Node.equal(x.relation, y.relation) and Node.equal(x.where_clause, y.where_clause) and Node.list_equal(x.columns, y.columns)
			(RangeFunction(x), RangeFunction(y)) => x.lateral == y.lateral and x.ordinality == y.ordinality and x.is_rowsfrom == y.is_rowsfrom and Node.list_equal(x.functions, y.functions) and Node.equal(x.alias, y.alias) and Node.list_equal(x.coldeflist, y.coldeflist)
			(RangeSubselect(x), RangeSubselect(y)) => x.lateral == y.lateral and Node.equal(x.subquery, y.subquery) and Node.equal(x.alias, y.alias)
			(RangeTableFunc(x), RangeTableFunc(y)) => x.lateral == y.lateral and Node.equal(x.docexpr, y.docexpr) and Node.equal(x.rowexpr, y.rowexpr) and Node.list_equal(x.namespaces, y.namespaces) and Node.list_equal(x.columns, y.columns) and Node.equal(x.alias, y.alias)
			(RangeTableFuncCol(x), RangeTableFuncCol(y)) => x.colname == y.colname and Node.equal(x.type_name, y.type_name) and x.for_ordinality == y.for_ordinality and x.is_not_null == y.is_not_null and Node.equal(x.colexpr, y.colexpr) and Node.equal(x.coldefexpr, y.coldefexpr)
			(RangeTableSample(x), RangeTableSample(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.method, y.method) and Node.list_equal(x.args, y.args) and Node.equal(x.repeatable, y.repeatable)
			(RangeVar(x), RangeVar(y)) => x.catalogname == y.catalogname and x.schemaname == y.schemaname and x.relname == y.relname and x.inh == y.inh and x.relpersistence == y.relpersistence and Node.equal(x.alias, y.alias)
			(RawStmt(x), RawStmt(y)) => Node.equal(x.stmt, y.stmt)
			(ReassignOwnedStmt(x), ReassignOwnedStmt(y)) => Node.list_equal(x.roles, y.roles) and Node.equal(x.newrole, y.newrole)
			(RefreshMatViewStmt(x), RefreshMatViewStmt(y)) => x.concurrent == y.concurrent and x.skip_data == y.skip_data and Node.equal(x.relation, y.relation)
			(ReindexStmt(x), ReindexStmt(y)) => x.kind == y.kind and Node.equal(x.relation, y.relation) and x.name == y.name and Node.list_equal(x.params, y.params)
			(RenameStmt(x), RenameStmt(y)) => x.rename_type == y.rename_type and x.relation_type == y.relation_type and Node.equal(x.relation, y.relation) and Node.equal(x.object, y.object) and x.subname == y.subname and x.newname == y.newname and x.behavior == y.behavior and x.missing_ok == y.missing_ok
			(ReplicaIdentityStmt(x), ReplicaIdentityStmt(y)) => x.identity_type == y.identity_type and x.name == y.name
			(ResTarget(x), ResTarget(y)) => x.name == y.name and Node.list_equal(x.indirection, y.indirection) and Node.equal(x.val, y.val)
			(ReturnStmt(x), ReturnStmt(y)) => Node.equal(x.returnval, y.returnval)
			(ReturningClause(x), ReturningClause(y)) => Node.list_equal(x.options, y.options) and Node.list_equal(x.exprs, y.exprs)
			(ReturningOption(x), ReturningOption(y)) => x.option == y.option and x.value == y.value
			(RoleSpec(x), RoleSpec(y)) => x.roletype == y.roletype and x.rolename == y.rolename
			(RowExpr(x), RowExpr(y)) => Node.list_equal(x.args, y.args) and x.row_typeid == y.row_typeid and Node.list_equal(x.colnames, y.colnames)
			(RuleStmt(x), RuleStmt(y)) => Node.equal(x.relation, y.relation) and x.rulename == y.rulename and Node.equal(x.where_clause, y.where_clause) and x.event == y.event and x.instead == y.instead and Node.list_equal(x.actions, y.actions) and x.replace == y.replace
			(SQLValueFunction(x), SQLValueFunction(y)) => x.op == y.op and x.type == y.type and x.typmod == y.typmod
			(SecLabelStmt(x), SecLabelStmt(y)) => x.objtype == y.objtype and Node.equal(x.object, y.object) and x.provider == y.provider and x.label == y.label
			(SelectLimit(x), SelectLimit(y)) => Node.equal(x.limit_offset, y.limit_offset) and Node.equal(x.limit_count, y.limit_count) and x.limit_option == y.limit_option
			(SelectStmt(x), SelectStmt(y)) => Node.list_equal(x.distinct_clause, y.distinct_clause) and Node.equal(x.into_clause, y.into_clause) and Node.list_equal(x.target_list, y.target_list) and Node.list_equal(x.from_clause, y.from_clause) and Node.equal(x.where_clause, y.where_clause) and Node.list_equal(x.group_clause, y.group_clause) and x.group_distinct == y.group_distinct and Node.equal(x.having_clause, y.having_clause) and Node.list_equal(x.window_clause, y.window_clause) and Node.list_equal(x.values_lists, y.values_lists) and Node.list_equal(x.sort_clause, y.sort_clause) and Node.equal(x.limit_offset, y.limit_offset) and Node.equal(x.limit_count, y.limit_count) and x.limit_option == y.limit_option and Node.list_equal(x.locking_clause, y.locking_clause) and Node.equal(x.with_clause, y.with_clause) and x.op == y.op and x.all == y.all and Node.equal(x.larg, y.larg) and Node.equal(x.rarg, y.rarg)
			(SetToDefault(x), SetToDefault(y)) => x.type_id == y.type_id and x.type_mod == y.type_mod and x.collation == y.collation
			(SortBy(x), SortBy(y)) => Node.equal(x.node, y.node) and x.sortby_dir == y.sortby_dir and x.sortby_nulls == y.sortby_nulls and Node.list_equal(x.use_op, y.use_op)
			(StatsElem(x), StatsElem(y)) => x.name == y.name and Node.equal(x.expr, y.expr)
			(String(x), String(y)) => x.sval == y.sval
			(SubLink(x), SubLink(y)) => x.sub_link_type == y.sub_link_type and x.sub_link_id == y.sub_link_id and Node.equal(x.testexpr, y.testexpr) and Node.list_equal(x.oper_name, y.oper_name) and Node.equal(x.subselect, y.subselect)
			(TableLikeClause(x), TableLikeClause(y)) => Node.equal(x.relation, y.relation) and x.options == y.options and x.relation_oid == y.relation_oid
			(TransactionStmt(x), TransactionStmt(y)) => x.kind == y.kind and Node.list_equal(x.options, y.options) and x.savepoint_name == y.savepoint_name and x.gid == y.gid and x.chain == y.chain
			(TriggerTransition(x), TriggerTransition(y)) => x.name == y.name and x.is_new == y.is_new and x.is_table == y.is_table
			(TruncateStmt(x), TruncateStmt(y)) => Node.list_equal(x.relations, y.relations) and x.restart_seqs == y.restart_seqs and x.behavior == y.behavior
			(TypeCast(x), TypeCast(y)) => Node.equal(x.arg, y.arg) and Node.equal(x.type_name, y.type_name)
			(TypeName(x), TypeName(y)) => Node.list_equal(x.names, y.names) and x.type_oid == y.type_oid and x.setof == y.setof and x.pct_type == y.pct_type and Node.list_equal(x.typmods, y.typmods) and x.typemod == y.typemod and Node.list_equal(x.array_bounds, y.array_bounds)
			(UnlistenStmt(x), UnlistenStmt(y)) => x.conditionname == y.conditionname
			(UpdateStmt(x), UpdateStmt(y)) => Node.equal(x.relation, y.relation) and Node.list_equal(x.target_list, y.target_list) and Node.equal(x.where_clause, y.where_clause) and Node.list_equal(x.from_clause, y.from_clause) and Node.equal(x.returning_clause, y.returning_clause) and Node.equal(x.with_clause, y.with_clause)
			(VacuumRelation(x), VacuumRelation(y)) => Node.equal(x.relation, y.relation) and x.oid == y.oid and Node.list_equal(x.va_cols, y.va_cols)
			(VacuumStmt(x), VacuumStmt(y)) => Node.list_equal(x.options, y.options) and Node.list_equal(x.rels, y.rels) and x.is_vacuumcmd == y.is_vacuumcmd
			(VariableSetStmt(x), VariableSetStmt(y)) => x.kind == y.kind and x.name == y.name and Node.list_equal(x.args, y.args) and x.jumble_args == y.jumble_args and x.is_local == y.is_local
			(VariableShowStmt(x), VariableShowStmt(y)) => x.name == y.name
			(ViewStmt(x), ViewStmt(y)) => Node.equal(x.view, y.view) and Node.list_equal(x.aliases, y.aliases) and Node.equal(x.query, y.query) and x.replace == y.replace and Node.list_equal(x.options, y.options) and x.with_check_option == y.with_check_option
			(WindowDef(x), WindowDef(y)) => x.name == y.name and x.refname == y.refname and Node.list_equal(x.partition_clause, y.partition_clause) and Node.list_equal(x.order_clause, y.order_clause) and x.frame_options == y.frame_options and Node.equal(x.start_offset, y.start_offset) and Node.equal(x.end_offset, y.end_offset)
			(WithClause(x), WithClause(y)) => Node.list_equal(x.ctes, y.ctes) and x.recursive == y.recursive
			(XmlExpr(x), XmlExpr(y)) => x.op == y.op and x.name == y.name and Node.list_equal(x.named_args, y.named_args) and Node.list_equal(x.arg_names, y.arg_names) and Node.list_equal(x.args, y.args) and x.xmloption == y.xmloption and x.indent == y.indent and x.type == y.type and x.typmod == y.typmod
			(XmlSerialize(x), XmlSerialize(y)) => x.xmloption == y.xmloption and Node.equal(x.expr, y.expr) and Node.equal(x.type_name, y.type_name) and x.indent == y.indent
			_ => Bool.False
		}

	list_equal : List(Node), List(Node) -> Bool
	list_equal = |x, y| {
		if x.len() != y.len() {
			return Bool.False
		}
		var $i = 0
		while $i < x.len() {
			if !Node.equal(x.get($i) ?? Null, y.get($i) ?? Null) {
				return Bool.False
			}
			$i = $i + 1
		}
		Bool.True
	}
}
