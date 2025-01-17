class SkillsData {
  final List<SkillsDataItem> skillsData;
  Map<String, List<String>> get skillsByYear => Map.fromEntries(skillsData.map((e) => MapEntry(e.year, e.skills)));

  SkillsData(this.skillsData);

  static SkillsData fromMap(Map<String, List<String>> map) {
    return SkillsData(map.entries.map((e) => SkillsDataItem(e.key, e.value)).toList());
  }
}

class SkillsDataItem {
  final String year;
  final List<String> skills;

  SkillsDataItem(this.year, this.skills);
}