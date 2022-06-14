import 'package:flutter/material.dart';
import '../models/company_class.dart';

class SearchCompanyTile extends StatelessWidget {
  final Company company;

  const SearchCompanyTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            company.offerType == 'On Campus'
                ? '/onCampusCompanyPage'
                : '/offCampusCompanyPage',
            arguments: company);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const FlutterLogo(size: 40),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        company.roleName,
                        style: const TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Opacity(
                      opacity: 0.80,
                      child: Text(
                        company.companyName,
                        style: const TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 12,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                if (company.offerType == 'On Campus')
                  Chip(
                    name: company.roleType!,
                  ),
                if (company.offerType == 'On Campus')
                  Chip(
                    name: company.lastDate!,
                  ),
                const Spacer(),
                if (company.offerType == 'On Campus' && company.package != 0.0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      child: Text(
                        '${company.package} LPA',
                        style: const TextStyle(
                          color: Color(0xff18191e),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  final String name;

  const Chip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xfff4f6fc),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Opacity(
        opacity: 0.80,
        child: Text(
          name,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Color(0xff18191e),
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
