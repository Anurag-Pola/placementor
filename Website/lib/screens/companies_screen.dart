import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../screens/on_campus_company_form.dart';
import '../widgets/company_class.dart';
import '../widgets/on_campus_company_tile.dart';
import '../widgets/off_campus_company_tile.dart';
import 'off_campus_company_form.dart';

List<Company> searched = [];

List<String> companyTypeList = ["Product", "Service"];
List<String> roleTypeList = [
  "Full Time",
  "Internship",
  "Internship + Full Time",
  "Internship Based Full Time"
];
List<String> offerTypeList = ["On Campus", "Off Campus"];
List<String> companyNameList = ["Google", "JPMC"];
List<String> roleNameList = ["Software Engineer", "Software Developer"];
List<String> skillList = ["Python", "Java", "Flutter"];

List<String> selectedCompanyTypeList = [];
List<String> selectedRoleTypeList = [];
List<String> selectedOfferTypeList = [];
List<String> selectedCompanyNameList = [];
List<String> selectedRoleNameList = [];
List<String> selectedSkillList = [];

double packageMax = 14;
RangeValues _currentRangeValues = const RangeValues(0, 14);

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final myController = TextEditingController();
  bool toggleValue = true;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder<QuerySnapshot<Company>>(
      future: FirebaseFirestore.instance
          .collection('Companies')
          .withConverter<Company>(
            fromFirestore: (snapshot, _) => Company.fromJson(snapshot.data()!),
            toFirestore: (company, _) => company.toJson(),
          )
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Something went wrong');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Company> companies =
            snapshot.data!.docs.map((doc) => doc.data()).toList();
        List<Company> onCampusCompanies = companies
            .where((element) => element.offerType == "On Campus")
            .toList();
        List<Company> offCampusCompanies = companies
            .where((element) => element.offerType == "Off Campus")
            .toList();

        return Scaffold(
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            activeIcon: Icons.close,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            heroTag: 'speed-dial-hero-tag',
            elevation: 8.0,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.fort_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'Off Campus',
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OffCampusCompanyForm(),
                      ),
                    );
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.apartment_rounded),
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  label: 'On Campus',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnCampusCompanyForm(),
                      ),
                    );
                  }),
            ],
          ),
          backgroundColor: const Color(0xFFF7F9FC),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Switch(
                      activeThumbImage:
                          const AssetImage('assets/Images/login_pic.png'),
                      mouseCursor: SystemMouseCursors.click,
                      value: toggleValue,
                      onChanged: (value) {
                        setState(() {
                          toggleValue = !toggleValue;
                        });
                      })
                ],
              ),
              SearchBar(
                controller: myController,
                width: width,
                onChanged: (i) {
                  searched = (companies)
                      .where((x) =>
                          x.companyName.contains(i) |
                          x.companyName.toLowerCase().contains(i))
                      .toList();
                },
              ),
              toggleValue == true
                  ? Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 5,
                          ),
                          child: Text(
                            "On Campus",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height - 200,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 400,
                                    childAspectRatio: 1.4,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: OnCampusCompanyTile(
                                id: onCampusCompanies[index].id,
                                companyName:
                                    onCampusCompanies[index].companyName,
                                companyType:
                                    onCampusCompanies[index].companyType,
                                roleName: onCampusCompanies[index].roleName,
                                roleType: onCampusCompanies[index].roleType,
                                aboutTheFirm:
                                    onCampusCompanies[index].aboutTheFirm,
                                jobDescription:
                                    onCampusCompanies[index].jobDescription,
                                skillset: onCampusCompanies[index].skillset
                                    as List<String>,
                                processTimeline:
                                    onCampusCompanies[index].processTimeline,
                                previouslyPlacedContacts:
                                    onCampusCompanies[index]
                                        .previouslyPlacedContacts,
                                experienceTilesInfo:
                                    onCampusCompanies[index].experiences,
                                faqs: onCampusCompanies[index].faqs,
                                lastDate: onCampusCompanies[index].lastDate,
                                package: onCampusCompanies[index].package,
                                linkToApply:
                                    onCampusCompanies[index].linkToApply,
                                driveLink: onCampusCompanies[index].driveLink,
                                eligibility:
                                    onCampusCompanies[index].eligibility,
                                offerType: onCampusCompanies[index].offerType,
                              ),
                            ),
                            itemCount: onCampusCompanies.length,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 5,
                          ),
                          child: Text(
                            "Off Campus",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height - 200,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio: 1.3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) =>
                                OffCampusCompanyTile(
                              companyName:
                                  offCampusCompanies[index].companyName,
                              roleName: offCampusCompanies[index].roleName,
                              jobDescription:
                                  offCampusCompanies[index].jobDescription,
                              linkToApply:
                                  offCampusCompanies[index].linkToApply,
                              id: offCampusCompanies[index].id,
                            ),
                            itemCount: offCampusCompanies.length,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Function onChanged;

  const SearchBar(
      {Key? key,
      required this.controller,
      required this.width,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: width * 0.8,
            child: Center(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xffc4c4c4),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 13),
                    border: InputBorder.none,
                    hintText: 'Enter a search term'),
                onChanged: (value) => onChanged(value),
              ),
            ),
          ),
          const Spacer(),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              child: const Icon(Icons.filter_list_rounded),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => FilterAlertDialog());
              },
            ),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
    );
  }
}

const InputDecoration textFormFieldDecoration = InputDecoration(
  errorStyle: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w100,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: Color(0xffe5e5e5),
      width: 1,
    ),
  ),
  contentPadding: EdgeInsets.all(18),
  fillColor: Color(0xfff8f8f8),
);

const TextStyle textStyle = TextStyle(
  color: Color(0xff252b42),
  fontSize: 14,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
);

class FilterAlertDialog extends StatelessWidget {
  FilterAlertDialog({
    Key? key,
  }) : super(key: key);

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _roleNameController = TextEditingController();
  final TextEditingController _skillsetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter"),
      scrollable: true,
      content: Column(
        children: [
          const Text("Company Type"),
          Filter(
            chipsList: companyTypeList
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: selectedCompanyTypeList,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Role Type"),
          Filter(
            chipsList: roleTypeList
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: selectedRoleTypeList,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Offer Type"),
          Filter(
            chipsList: offerTypeList
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: selectedOfferTypeList,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Company Name"),
          LittleSearch(
            controller: _companyNameController,
            hintText: "Enter a Company Name",
            chipsList: companyNameList,
            selectedChipsList: selectedCompanyNameList,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Role Name"),
          LittleSearch(
            controller: _roleNameController,
            hintText: "Enter a Role Name",
            chipsList: roleNameList,
            selectedChipsList: selectedRoleNameList,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Skillset"),
          LittleSearch(
            controller: _skillsetController,
            hintText: "Enter the skill",
            chipsList: skillList,
            selectedChipsList: selectedSkillList,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Package Range (LPA)"),
          const PackageSlider(),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

class LittleSearch extends StatefulWidget {
  const LittleSearch({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required List<String> chipsList,
    required List<String> selectedChipsList,
  })  : _controller = controller,
        _hintText = hintText,
        _chipsList = chipsList,
        _selectedChipsList = selectedChipsList,
        super(key: key);

  final TextEditingController _controller;
  final String _hintText;
  final List<String> _chipsList;
  final List<String> _selectedChipsList;

  @override
  State<LittleSearch> createState() => _LittleSearchState();
}

class _LittleSearchState extends State<LittleSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget._hintText,
            style: textStyle,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {});
            },
            decoration: textFormFieldDecoration,
            autocorrect: true,
            controller: widget._controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 5,
          ),
          Filter(
            chipsList: widget._chipsList
                .where((element) => element
                    .toLowerCase()
                    .contains(widget._controller.text.toLowerCase()))
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: widget._selectedChipsList,
          ),
        ],
      ),
    );
  }
}

class Chip {
  String label;
  bool isSelected;
  Chip({required this.label, required this.isSelected});
}

class Filter extends StatefulWidget {
  const Filter({Key? key, required this.chipsList, required this.selectedChips})
      : super(key: key);

  final List<Chip> chipsList;
  final List<String> selectedChips;

  @override
  State<Filter> createState() => _Filter();
}

class _Filter extends State<Filter> {
  List<Widget> chips() {
    List<Widget> chips = [];
    for (int i = 0; i < widget.chipsList.length; i++) {
      Widget item = Container(
        padding: const EdgeInsets.only(left: 10, right: 5),
        margin: const EdgeInsets.all(5),
        child: FilterChip(
          label: Text(widget.chipsList[i].label),
          labelStyle: const TextStyle(color: Colors.white),
          selectedColor: Colors.green,
          selected: widget.selectedChips.contains(widget.chipsList[i].label)
              ? true
              : false,
          onSelected: (bool value) {
            setState(() {
              widget.chipsList[i].isSelected = value;
              if (value) {
                widget.selectedChips.add(widget.chipsList[i].label);
              } else {
                widget.selectedChips.remove(widget.chipsList[i].label);
              }
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      direction: Axis.horizontal,
      children: chips(),
    );
  }
}

class PackageSlider extends StatefulWidget {
  const PackageSlider({Key? key}) : super(key: key);

  @override
  State<PackageSlider> createState() => _PackageSliderState();
}

class _PackageSliderState extends State<PackageSlider> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: packageMax,
      divisions: packageMax.toInt(),
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
