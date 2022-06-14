import 'package:flutter/material.dart';

import '../models/companies_metadata_class.dart';
import '../models/companies_search_filter_class.dart';

// List<String> selectedCompanyTypeList = [];
// List<String> selectedRoleTypeList = [];
// List<String> selectedOfferTypeList = [];
// List<String> selectedCompanyNameList = [];
// List<String> selectedRoleNameList = [];
// List<String> selectedSkillList = [];

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

class FilterAlertDialog extends StatefulWidget {
  CompaniesMetadataClass companiesMetadata;
  CompaniesSearchFilter companiesSearchFilter;

  FilterAlertDialog({
    required this.companiesMetadata,
    required this.companiesSearchFilter,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterAlertDialog> createState() => _FilterAlertDialogState();
}

class _FilterAlertDialogState extends State<FilterAlertDialog> {
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
            chipsList: widget.companiesMetadata.companyTypes
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: widget.companiesSearchFilter.companyTypeFilter,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Role Type"),
          Filter(
            chipsList: widget.companiesMetadata.roleTypes
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: widget.companiesSearchFilter.roleTypeFilter,
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Offer Type"),
          Filter(
            chipsList: widget.companiesMetadata.offerTypes
                .map((e) => Chip(label: e, isSelected: false))
                .toList(),
            selectedChips: widget.companiesSearchFilter.offerTypeFilter,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Package Range (LPA)"),
          PackageSlider(
              packageMax: widget.companiesMetadata.packageMax,
              currentRangeValues: RangeValues(
                  widget.companiesSearchFilter.packageFilter[0].toDouble(),
                  widget.companiesSearchFilter.packageFilter[1].toDouble()),
              onRangeChanged: (int packageMin, int packageMax) {
                widget.companiesSearchFilter.packageFilter = [
                  packageMin,
                  packageMax
                ];
              }),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black38,
          ),
          const Text("Company Name"),
          LittleSearch(
            controller: _companyNameController,
            hintText: "Enter a Company Name",
            chipsList: widget.companiesMetadata.companyNames,
            selectedChipsList: widget.companiesSearchFilter.companyNameFilter,
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
            chipsList: widget.companiesMetadata.roleNames,
            selectedChipsList: widget.companiesSearchFilter.roleNameFilter,
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
            chipsList: widget.companiesMetadata.skillset,
            selectedChipsList: widget.companiesSearchFilter.skillsetFilter,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Clear"),
          onPressed: () {
            setState(() {
              _companyNameController.clear();
              _roleNameController.clear();
              _skillsetController.clear();
              widget.companiesSearchFilter.clearFilter();
            });
          },
        ),
        TextButton(
          child: const Text("Apply"),
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
    required List chipsList,
    required List selectedChipsList,
  })  : _controller = controller,
        _hintText = hintText,
        _chipsList = chipsList,
        _selectedChipsList = selectedChipsList,
        super(key: key);

  final TextEditingController _controller;
  final String _hintText;
  final List _chipsList;
  final List _selectedChipsList;

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
                return 'Please enter search text';
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
  final List selectedChips;

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
  RangeValues currentRangeValues;
  final double packageMax;
  final Function onRangeChanged;
  PackageSlider(
      {required this.packageMax,
      required this.currentRangeValues,
      required this.onRangeChanged,
      Key? key})
      : super(key: key);

  @override
  State<PackageSlider> createState() => _PackageSliderState();
}

class _PackageSliderState extends State<PackageSlider> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: widget.currentRangeValues,
      max: widget.packageMax.toInt() + 1,
      divisions: widget.packageMax.toInt() + 1,
      labels: RangeLabels(
        widget.currentRangeValues.start.round().toString(),
        widget.currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          widget.currentRangeValues = values;
          widget.onRangeChanged(values.start.toInt(), values.end.toInt());
        });
      },
    );
  }
}
