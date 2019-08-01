import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

Builder infoBuilder(BuilderOptions options) => InfoBuilder();

class InfoBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    final html = await getReflectionData(
        buildStep, ["dart.dom.html", "universal_html.without_internals"]);

    // Generate "main-generated-data.dart"
    var assetId = buildStep.inputId.changeExtension("-generated-data.dart");
    final content = _generateContent(html);
    await buildStep.writeAsString(assetId, content);
  }

  String _generateContent(Map<String, Object> html) {
    final result = StringBuffer();
    result.writeln("// IMPORTANT: DO NOT MODIFY");
    result.writeln(
        "// This file has been generated with 'tool/generate_reflection.sh'.");
    result
        .writeln("const Map<String,Object> reflectionData = <String,Object>{");
    for (var libraryName in html.keys.toList()..sort()) {
      result.writeln("  '$libraryName': <String,Object>{");
      final library = html[libraryName];
      for (var apiName in (library as Map<String, Object>).keys) {
        result.writeln("    '$apiName': null,");
      }
      result.writeln("  },");
    }
    result.writeln("};");
    return result.toString();
  }

  Future<Map<String, Object>> getReflectionData(
      BuildStep buildStep, List<String> libraryNames) async {
    final result = <String, Object>{};
    for (var libraryName in libraryNames) {
      final library = await buildStep.resolver.findLibraryByName(libraryName);
      if (library == null) {
        final libraries = await buildStep.resolver.libraries.toList();
        throw StateError(
            "Could not find '$libraryName'. Available libraries are:\n  ${libraries.join("\n  ")}");
      }
      final libraryInfo = Map<String, Object>();
      for (var member in library.exportNamespace.definedNames.values) {
        if (member.isPrivate ||
            member.hasDeprecated ||
            member.hasVisibleForTesting ||
            member.hasVisibleForTemplate) {
          continue;
        }
        if (member is ClassElement) {
          libraryInfo["${member.name} (class)"] = null;
          _addClassMembers(libraryInfo, member.name, member, false);
        } else {
          libraryInfo[member.name] = "";
        }
      }
      result[libraryName] = libraryInfo;
    }
    return result;
  }

  static void _addClassMembers(Map<String, Object> set, String className,
      ClassElement classElement, bool isInherited) {
    if (classElement.name == "Object") {
      return;
    }

    // ------------
    // Constructors
    // ------------
    if (!isInherited) {
      final constructors = classElement.constructors;
      if (constructors.isEmpty) {
        // Implicit constructor
        set["$className.$className"] = "";
      } else {
        for (var member in constructors) {
          if (member.isPrivate ||
              member.hasDeprecated ||
              member.hasVisibleForTesting ||
              member.hasVisibleForTemplate) {
            continue;
          }
          var name = member.name;
          if (name == "") {
            name = className;
          }
          set["$className.$name"] = null;
        }
      }
    }
    // ------
    // Fields
    // ------
    for (var member in classElement.fields) {
      if (_isIgnoredClassMember(member, isInherited)) {
        continue;
      }
      set["$className.${member.name}"] = "";
      if (!(member.isFinal || member.isConst)) {
        set["$className.${member.name}="] = null;
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
          _ignoredMembers.contains(member.name)) {
        continue;
      }
      set["$className.${member.name}"] = null;
    }

    // -------
    // Methods
    // -------
    for (var member in classElement.methods) {
      if (_isIgnoredClassMember(member, isInherited)) {
        continue;
      }
      set["$className.${member.name}"] = null;
    }

    // -----------------
    // Inherited members
    // -----------------
    _addClassMembers(set, className, classElement.supertype.element, true);
    for (var type in classElement.mixins) {
      _addClassMembers(set, className, type.element, true);
    }
    for (var type in classElement.interfaces) {
      _addClassMembers(set, className, type.element, true);
    }
  }

  static bool _isIgnoredClassMember(
      ClassMemberElement member, bool isInherited) {
    return (isInherited && member.isStatic) ||
        member.isPrivate ||
        member.hasDeprecated ||
        member.hasVisibleForTesting ||
        member.hasVisibleForTemplate ||
        _ignoredMembers.contains(member.name);
  }

  static final _ignoredMembers = {
    "toString",
    "==",
    "hashCode",
    "noSuchMethod",
    "runtimeType"
  };

  @override
  final buildExtensions = const {
    ".dart": ["-generated-data.dart"]
  };
}
