import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shamo_mobile/core/core.dart';

class PhoneTextInput extends StatefulWidget {
  const PhoneTextInput({
    Key? key,
    this.style,
    this.onChange,
    this.focusNode,
    this.inputAction,
    this.onSubmit,
    this.readOnly,
    this.hintText,
    this.errorText,
    this.suffix,
    this.label,
    this.isRequired,
    required this.controller,
  }) : super(key: key);

  final TextStyle? style;
  final ValueChanged<String>? onChange;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final ValueChanged<String>? onSubmit;
  final bool? readOnly;
  final String? hintText;
  final String? errorText;
  final Widget? suffix;
  final String? label;
  final bool? isRequired;
  final TextEditingController controller;

  @override
  State<PhoneTextInput> createState() => _PhoneTextInputState();
}

class _PhoneTextInputState extends State<PhoneTextInput> {
  Country _currentCountry = CountriesData.data.first;

  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _initializeFormatPhone();
    super.initState();
  }

  @override
  void setState(Function fn) {
    if (mounted) {
      super.setState(fn as void Function());
    }
  }

  @override
  void didUpdateWidget(covariant PhoneTextInput oldWidget) {
    if (getCurrentValue() != oldWidget.controller.text.replaceAll('+', '')) {
      if (widget.controller.text.isEmpty) {
        _phoneController.text = '';
      }
      _initializeFormatPhone();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initializeFormatPhone() {
    var isFoundCountry = false;

    if (widget.controller.text.isNotEmpty) {
      for (final item in CountriesData.data) {
        final currentCountryCode = item.dialCode.replaceAll('+', '');

        final valueParam = widget.controller.text.replaceAll('+', '');

        if (valueParam.startsWith(currentCountryCode)) {
          if (valueParam != getCurrentValue()) {
            _currentCountry = item;
            _phoneController.text =
                valueParam.replaceFirst(currentCountryCode, '');
            phoneNumberControllerListener();
            isFoundCountry = true;
          }
          break;
        }
      }

      if (!isFoundCountry) {
        _phoneController.text = int.tryParse(widget.controller.text).toString();
        phoneNumberControllerListener();
      }
    }
  }

  void phoneNumberControllerListener() {
    if (mounted) {
      if (widget.onChange != null) {
        widget.onChange?.call(getCurrentValue());
      }

      widget.controller.text = getCurrentValue();
    }
  }

  String getCurrentValue() {
    final number = int.tryParse(_phoneController.text);
    return (_currentCountry.dialCode).replaceFirst('+', '') +
        (number ?? '').toString();
  }

  @override
  Widget build(BuildContext context) {
    return RegularInput(
      label: widget.label,
      style: widget.style,
      onChange: (_) => phoneNumberControllerListener(),
      prefix: _buildPrefix(),
      focusNode: widget.focusNode,
      inputAction: widget.inputAction ?? TextInputAction.done,
      inputType: TextInputType.phone,
      onSubmit: widget.onSubmit,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      readOnly: widget.readOnly ?? false,
      controller: _phoneController,
      hintText: widget.hintText,
      suffix: widget.suffix,
      errorText: widget.errorText,
      isRequired: widget.isRequired,
    );
  }

  Widget _buildPrefix() {
    return Container(
      height: Dimens.dp28,
      padding: const EdgeInsets.only(left: Dimens.dp16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (widget.readOnly ?? false) ? null : _showPickCountry,
            child: _buildItemCountry(_currentCountry),
          ),
          if (!(widget.readOnly ?? false))
            const Icon(
              Icons.expand_more,
              size: Dimens.dp16,
            ),
          SizedBox(
            height: Dimens.dp24,
            child: VerticalDivider(
              thickness: 1.5,
              width: Dimens.dp32,
              color: context.adaptiveTheme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCountry(Country phone) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          phone.flag,
          width: Dimens.dp16,
          height: Dimens.dp16,
        ),
        const SizedBox(width: Dimens.dp8),
        RegularText.normalSolid(
          context,
          phone.dialCode,
          style: TextStyle(
            fontSize: 14,
            color: context.theme.scaffoldBackgroundColor,
          ),
        ),
      ],
    );
  }

  void onCountryChanged(Country v) {
    setState(() {
      _currentCountry = v;
    });
    phoneNumberControllerListener();
  }

  void _showPickCountry() {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ContentSheet(
        height: Dimens.height(context) * 0.8,
        content: _CountryList(
          onChange: onCountryChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

class _CountryList extends StatefulWidget {
  const _CountryList({Key? key, this.onChange}) : super(key: key);

  final ValueChanged<Country>? onChange;

  @override
  __CountryListState createState() => __CountryListState();
}

class __CountryListState extends State<_CountryList> {
  final TextEditingController _controller = TextEditingController();
  final List<Country> _searchData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
          child: SearchTextInput(
            controller: _controller,
            hintText: 'Search Phone',
            onChanged: (value) => _onSearch(),
            onClear: () {
              _controller.clear();
              _onSearch();
            },
          ),
        ),
        const SizedBox(height: Dimens.dp16),
        if (_controller.text.isEmpty)
          _buildListCountry(CountriesData.data)
        else
          _buildListCountry(_searchData),
      ],
    );
  }

  Widget _buildListCountry(List<Country> data) {
    return Expanded(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          return ListTile(
            onTap: () {
              if (widget.onChange != null) {
                widget.onChange!(data[i]);
                Navigator.of(context).pop();
              }
            },
            leading: Image.asset(
              data[i].flag,
              width: Dimens.dp24,
              height: Dimens.dp24,
            ),
            title: Text(data[i].name),
            trailing: Text(data[i].dialCode),
          );
        },
        separatorBuilder: (_, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
            child: Divider(
              height: 1,
              thickness: .3,
              color: context.adaptiveTheme.disabledColor,
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  void _onSearch() {
    _searchData.clear();
    for (final item in CountriesData.data) {
      if (item.name.toLowerCase().contains(_controller.text.toLowerCase()) ||
          item.dialCode.contains(_controller.text)) {
        _searchData.add(item);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
