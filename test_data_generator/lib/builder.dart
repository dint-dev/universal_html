import 'package:analyzer/dart/element/element.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:build/build.dart';

Builder infoBuilder(BuilderOptions options) => InfoBuilder();

class InfoBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    final html = await getReflectionData(
        buildStep, ['dart.dom.html', 'universal_html.internal']);

    // Generate "main-generated-data.dart"
    var assetId = buildStep.inputId.changeExtension('-generated-data.dart');
    final content = _generateContent(html);
    await buildStep.writeAsString(assetId, content);
  }

  String _generateContent(Map<String, Object?> html) {
    final result = StringBuffer();
    result.writeln('// IMPORTANT: DO NOT MODIFY');
    result.writeln(
        "// This file has been generated with 'tool/generate_test_data.sh'.");
    result.writeln(
        'const Map<String,Object?> reflectionData = <String,Object?>{');
    for (var libraryName in html.keys.toList()..sort()) {
      result.writeln("  '$libraryName': <String,Object?>{");
      final library = html[libraryName];
      for (var apiName in (library as Map<String, Object>).keys) {
        result.writeln("    '$apiName': null,");
      }
      result.writeln('  },');
    }
    result.writeln('};');
    return result.toString();
  }

  Future<Map<String, Object>> getReflectionData(
      BuildStep buildStep, List<String> libraryNames) async {
    final result = <String, Object>{};
    for (var libraryName in libraryNames) {
      final library = await buildStep.resolver.findLibraryByName(libraryName);
      if (library == null) {
        final libraries = await buildStep.resolver.libraries.toList();
        final names = libraries.map((e) => e.name).toList();
        names.sort();
        throw StateError(
          'Missing library: $libraryName\n'
          'Available libraries:\n  ${names.join('\n  ')}',
        );
      }
      final libraryInfo = <String, Object?>{};
      for (var member in library.exportNamespace.definedNames.values) {
        if (member.isPrivate ||
            member.hasDeprecated ||
            member.hasVisibleForTesting ||
            member.hasVisibleForTemplate) {
          continue;
        }
        if (member is ClassElement) {
          if (member.name == 'Object' || member.name.startsWith('Internal')) {
            continue;
          }
          libraryInfo['${member.name} (class)'] = null;
          _addClassMembers(
            libraryInfo,
            member.name,
            classElement: member,
            isInherited: false,
          );
        } else {
          libraryInfo[member.name!] = '';
        }
      }
      result[libraryName] = libraryInfo;
    }
    return result;
  }

  static void _addClassMembers(
    Map<String, Object?> result,
    String className, {
    required InterfaceElement classElement,
    required bool isInherited,
  }) {
    if (className != classElement.name) {
      result['$className implements ${classElement.name}'];
    }

    // ------------
    // Constructors
    // ------------
    if (!isInherited) {
      final constructors = classElement.constructors;
      if (constructors.isEmpty) {
        // Implicit constructor
        result['$className.$className'] = '';
      } else {
        for (var member in constructors) {
          if (member.isPrivate ||
              member.hasDeprecated ||
              member.hasVisibleForTesting ||
              member.hasVisibleForTemplate ||
              member.name.startsWith('internal')) {
            continue;
          }
          var name = member.name;
          if (name == '') {
            name = className;
          }
          result['$className.$name'] = null;
        }
      }
    }

    // ------
    // Fields
    // ------
    for (var member in classElement.fields) {
      if (_isIgnoredClassMember(member, isInherited) ||
          member.name.startsWith('internal')) {
        continue;
      }
      result['$className.${member.name}'] = '';
      if (!(member.isFinal || member.isConst)) {
        result['$className.${member.name}='] = null;
      }
    }

    // ---------
    // Accessors
    // ---------
    for (var member in classElement.accessors) {
      if ((isInherited && member.isStatic) ||
          member.isPrivate ||
          member.hasDeprecated ||
          member.hasVisibleForTesting ||
          member.hasVisibleForTemplate ||
          _ignoredMembers.contains(member.name) ||
          member.name.startsWith('internal')) {
        continue;
      }
      result['$className.${member.displayName}'] = null;
    }

    // -------
    // Methods
    // -------
    for (var member in classElement.methods) {
      if (_isIgnoredClassMember(member, isInherited)) {
        continue;
      }
      result['$className.${member.displayName}(...)'] = null;
    }

    // -----------------
    // Inherited members
    // -----------------
    final superType = classElement.supertype;
    if (superType != null) {
      _addClassMembers(
        result,
        className,
        classElement: superType.element,
        isInherited: true,
      );
    }
    for (var type in classElement.mixins) {
      _addClassMembers(
        result,
        className,
        classElement: type.element,
        isInherited: true,
      );
    }
    for (var type in classElement.interfaces) {
      _addClassMembers(
        result,
        className,
        classElement: type.element,
        isInherited: true,
      );
    }
  }

  static bool _isIgnoredClassMember(
      ClassMemberElement member, bool isInherited) {
    return (isInherited && member.isStatic) ||
        member.isPrivate ||
        member.hasDeprecated ||
        member.hasVisibleForTesting ||
        member.hasVisibleForTemplate ||
        _ignoredMembers.contains(member.name) ||
        member.name!.startsWith('internal');
  }

  static final _ignoredMembers = {
    'toString',
    '==',
    'hashCode',
    'noSuchMethod',
    'runtimeType'
  };

  @override
  final buildExtensions = const {
    '.dart': ['-generated-data.dart']
  };
}
