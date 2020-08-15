#!/bin/bash

# firstly add dartfix to PATH: export PATH="$PATH:`pwd`/.pub-cache/bin"
# source .bashrc

cd lib

#--fix=prefer_final_locals

INCLUDE="
    --fix=annotate_overrides\
    --fix=avoid_empty_else\
    --fix=avoid_init_to_null\
    --fix=avoid_relative_lib_imports\
    --fix=avoid_return_types_on_setters\
    --fix=diagnostic_describe_all_properties\
    --fix=empty_catches\
    --fix=empty_constructor_bodies\
    --fix=empty_statements\
    --fix=no_duplicate_case_values\
    --fix=non_constant_identifier_names\
    --excludeFix=prefer_adjacent_string_concatenation\
    --excludeFix=omit_local_variable_types\
    --fix=prefer_collection_literals\
    --fix=prefer_conditional_assignment\
    --fix=prefer_contains\
    --fix=prefer_final_fields\
    --fix=prefer_for_elements_to_map_fromIterable\
    --fix=prefer_generic_function_type_aliases\
    --fix=prefer_if_elements_to_conditional_expressions\
    --fix=prefer_if_null_operators\
    --fix=prefer_inlined_adds\
    --fix=prefer_is_empty\
    --fix=prefer_is_not_empty\
    --fix=prefer_single_quotes\
    --fix=prefer_spread_collections\
    --fix=prefer_final_locals\
    --fix=type_init_formals\
    --fix=unnecessary_brace_in_string_interps\
    --fix=unnecessary_const\
    --fix=unnecessary_new\
    --fix=unnecessary_this\
    --fix=unnecessary_overrides"

files="$(find . -type d\
    -path './app' -or\
    -path './base' -or\
    -path './base_ui' -or\
    \( -path './blocs/*' -and -not -path './blocs/models' -and -not -path './blocs/models/*' \) -or\
    -path './components' -or\
    -path './containers' -or\
    -path './data/network/service' -or\
    -path './di/provider' -or\
    -path './exception' -or\
    -path './l10n' -or\
    -path './navigation' -or\
    -path './packages' -or\
    -path './ui_library' -or\
    -path './utilities' -or\
    -path './domain/mapper' -or\
    -path './domain/reducers' -or\
    -path './domain/selectors' -or\
    -path './domain/middleware' -or\
    -path './repository/bet' -or\
    -path './repository/cms' -or\
    -path './repository/error' -or\
    -path './repository/events/endpoint' -or\
    -path './repository/sportbook/endpoint'\
)"
# echo "Count: $(echo -n "$files" | wc -l)"

for name in $files
do
    # echo $name
    dartfix "$name" $INCLUDE --pedantic -w
done