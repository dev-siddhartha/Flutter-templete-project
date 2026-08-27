import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:slds_flutter/slds_flutter.dart';

/// Runs the SLDS Alpha component gallery.
void main() {
  runApp(const SldsExampleApp());
}

/// Demo application for Tier 1 and Tier 2 SLDS Flutter components.
class SldsExampleApp extends StatefulWidget {
  /// Creates the demo application.
  const SldsExampleApp({super.key});

  @override
  State<SldsExampleApp> createState() => _SldsExampleAppState();
}

class _SldsExampleAppState extends State<SldsExampleApp> {
  Locale _locale = const Locale('en');
  SldsTokenSet _tokens = SldsTokenSet.light();
  var _checked = true;
  var _radio = 'sms';
  var _toggle = true;
  var _district = 'colombo';
  var _selectedTab = 0;
  var _page = 2;

  final TextEditingController _textAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final copy = _Copy.forLocale(_locale);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('si'), Locale('ta')],
      home: SldsTheme(
        data: _tokens,
        child: Builder(
          builder: (context) {
            final tokens = context.slds;

            return Scaffold(
              backgroundColor: tokens.colors.surfacePage,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(tokens.dimensions.space24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PreviewHeader(
                        locale: _locale,
                        onLocaleChanged: (locale) =>
                            setState(() => _locale = locale),
                        onLightMode: () =>
                            setState(() => _tokens = SldsTokenSet.light()),
                        onDarkMode: () =>
                            setState(() => _tokens = SldsTokenSet.dark()),
                        onHighContrast: () => setState(
                          () => _tokens = SldsTokenSet.highContrast(),
                        ),
                      ),
                      SizedBox(height: tokens.dimensions.space24),
                      _ComponentSection(
                        tier: 'Tier 1',
                        title: 'Core form and feedback components',
                        count: '11 components',
                        children: _tier1Components(context, copy),
                      ),
                      SizedBox(height: tokens.dimensions.space24),
                      _ComponentSection(
                        tier: 'Tier 2',
                        title: 'Navigation and data-display components',
                        count: '11 components',
                        children: _tier2Components(context, copy),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _tier1Components(BuildContext context, _Copy copy) {
    final tokens = context.slds;

    return [
      _PreviewTile(
        title: 'Button',
        description: 'Primary, secondary, ghost, and destructive actions.',
        child: Wrap(
          spacing: tokens.dimensions.space8,
          runSpacing: tokens.dimensions.space8,
          children: [
            SldsButton(onPressed: () {}, child: Text(copy.buttonPrimary)),
            SldsButton(
              variant: SldsButtonVariant.secondary,
              onPressed: () {},
              child: Text(copy.buttonSecondary),
            ),
            SldsButton(
              variant: SldsButtonVariant.ghost,
              onPressed: () {},
              child: Text(copy.buttonGhost),
            ),
            SldsButton(
              variant: SldsButtonVariant.destructive,
              onPressed: () {},
              child: Text(copy.buttonDestructive),
            ),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Input',
        description: 'Citizen contact email for service updates.',
        child: SldsInput(
          controller: TextEditingController(),
          label: copy.emailLabel,
          placeholder: copy.emailAddress,
          helperText: copy.emailHelper,
          keyboardType: TextInputType.emailAddress,
          required: true,
          leading: const Icon(Icons.alternate_email),
        ),
      ),
      _PreviewTile(
        title: 'Text Area',
        description: 'Long-form request details with helper text.',
        child: SldsTextArea(
          label: copy.description,
          placeholder: copy.descriptionHint,
          helperText: copy.descriptionHelper,
          controller: _textAreaController,
          maxLength: 300,
        ),
      ),
      _PreviewTile(
        title: 'Checkbox',
        description: 'Single confirmation control.',
        child: SldsCheckbox(
          value: _checked,
          onChanged: (value) => setState(() => _checked = value),
          label: copy.checkbox,
        ),
      ),
      _PreviewTile(
        title: 'Radio',
        description: 'Single choice from a related option set.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SldsRadio<String>(
              value: 'sms',
              groupValue: _radio,
              onChanged: (value) => setState(() => _radio = value!),
              label: copy.radioSms,
            ),
            SizedBox(height: tokens.dimensions.space8),
            SldsRadio<String>(
              value: 'email',
              groupValue: _radio,
              onChanged: (value) => setState(() => _radio = value!),
              label: copy.radioEmail,
            ),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Toggle',
        description: 'Binary setting with adjacent text label.',
        child: Row(
          children: [
            SldsToggle(
              value: _toggle,
              onChanged: (value) => setState(() => _toggle = value),
              semanticLabel: copy.toggle,
            ),
            SizedBox(width: tokens.dimensions.space8),
            Flexible(child: Text(copy.toggle)),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Dropdown',
        description: 'District selector with localized item labels.',
        child: SldsDropdown<String>(
          label: copy.district,
          value: _district,
          placeholder: copy.districtPlaceholder,
          helperText: copy.districtHelper,
          onChanged: (value) => setState(() => _district = value!),
          items: [
            SldsDropdownItem(value: 'colombo', label: copy.districtColombo),
            SldsDropdownItem(value: 'galle', label: copy.districtGalle),
            SldsDropdownItem(
                value: 'batticaloa', label: copy.districtBatticaloa),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Badge',
        description: 'Status badges for request lifecycle states.',
        child: Wrap(
          spacing: tokens.dimensions.space8,
          runSpacing: tokens.dimensions.space8,
          children: [
            SldsBadge(label: copy.badgeApproved, type: SldsBadgeType.approved),
            SldsBadge(label: copy.badgeInReview, type: SldsBadgeType.inReview),
            SldsBadge(label: copy.badgeRejected, type: SldsBadgeType.rejected),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Card',
        description: 'Container for service summary content.',
        child: SldsCard(
          variant: SldsCardVariant.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                copy.cardTitle,
                style: tokens.typography.title1.copyWith(
                  color: tokens.colors.textPrimary,
                ),
              ),
              SizedBox(height: tokens.dimensions.space4),
              Text(
                copy.cardBody,
                style: tokens.typography.body2.copyWith(
                  color: tokens.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
      _PreviewTile(
        title: 'Dialog',
        description: 'Confirmation surface with paired actions.',
        child: SldsDialog(
          title: copy.dialogTitle,
          message: copy.dialogBody,
          primaryAction: SldsButton(
            size: SldsButtonSize.small,
            onPressed: () {},
            child: Text(copy.dialogPrimary),
          ),
          secondaryAction: SldsButton(
            size: SldsButtonSize.small,
            variant: SldsButtonVariant.secondary,
            onPressed: () {},
            child: Text(copy.dialogSecondary),
          ),
        ),
      ),
      _PreviewTile(
        title: 'Snackbar',
        description: 'Inline live-region preview for save feedback.',
        child: SldsSnackbar(
          title: copy.snackbarTitle,
          description: copy.snackbarBody,
          actionLabel: copy.snackbarAction,
          onAction: () {},
        ),
      ),
    ];
  }

  List<Widget> _tier2Components(BuildContext context, _Copy copy) {
    final tokens = context.slds;

    return [
      _PreviewTile(
        title: 'Tab',
        description: 'Section switching inside a workflow page.',
        child: SldsTabBar(
          selectedIndex: _selectedTab,
          onChanged: (index) => setState(() => _selectedTab = index),
          items: [
            SldsTabItem(label: copy.tabOverview, badgeCount: 2),
            SldsTabItem(label: copy.tabHistory),
            SldsTabItem(label: copy.tabFiles),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Accordion',
        description: 'Expandable help and document requirements.',
        child: SldsAccordion(
          title: copy.accordionTitle,
          child: Text(copy.accordionBody),
        ),
      ),
      _PreviewTile(
        title: 'List',
        description: 'Actionable service request row.',
        child: SldsListItem(
          title: copy.listTitle,
          description: copy.listBody,
          leading: const Icon(Icons.work_outline),
          badge: SldsBadge(
            label: copy.badgeApproved,
            type: SldsBadgeType.approved,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ),
      _PreviewTile(
        title: 'Pagination',
        description: 'Page controls for long result sets.',
        child: SldsPagination(
          currentPage: _page,
          totalPages: 5,
          onPageChanged: (value) => setState(() => _page = value),
        ),
      ),
      _PreviewTile(
        title: 'Progress',
        description: 'Segmented completion feedback.',
        child: SldsProgressBar(
          value: 60,
          semanticLabel: copy.progressLabel,
        ),
      ),
      _PreviewTile(
        title: 'Stepper',
        description: 'Step indicator for multi-step forms.',
        child: SldsStepper(
          totalSteps: 6,
          currentStep: 3,
          semanticLabel: copy.stepperLabel,
        ),
      ),
      _PreviewTile(
        title: 'Avatar',
        description: 'Citizen or officer identity marker.',
        child: Wrap(
          spacing: tokens.dimensions.space8,
          runSpacing: tokens.dimensions.space8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SldsAvatar(
              initials: copy.avatarInitials,
              semanticLabel: copy.avatarLabel,
            ),
            SldsAvatar(
              icon: Icons.person_outline,
              semanticLabel: copy.avatarLabel,
            ),
          ],
        ),
      ),
      _PreviewTile(
        title: 'Chip',
        description: 'Removable filter or selected value.',
        child: SldsChip(
          label: copy.chip,
          avatar: SldsAvatar(initials: copy.avatarInitials),
          onDeleted: () {},
          semanticLabel: copy.chipRemove,
        ),
      ),
      _PreviewTile(
        title: 'Tag',
        description: 'Compact metadata marker.',
        child: SldsTag(
          label: copy.tag,
          type: SldsBadgeType.pending,
        ),
      ),
      _PreviewTile(
        title: 'Tooltip',
        description: 'Short contextual explanation.',
        child: SldsTooltip(
          title: copy.tooltipTitle,
          description: copy.tooltipBody,
          detail: copy.tooltipDetail,
          actionLabel: copy.tooltipAction,
          onAction: () {},
          variant: SldsTooltipVariant.action,
        ),
      ),
      _PreviewTile(
        title: 'Navigation Drawer',
        description: 'Mobile service navigation pattern.',
        child: SldsNavigationDrawer(
          title: copy.drawerTitle,
          items: [
            SldsNavigationDrawerItem(
              label: copy.drawerHome,
              description: copy.drawerHomeBody,
              icon: Icons.home_outlined,
              selected: true,
              onTap: () {},
            ),
            SldsNavigationDrawerItem(
              label: copy.drawerApplications,
              description: copy.drawerApplicationsBody,
              icon: Icons.folder_outlined,
              onTap: () {},
            ),
          ],
        ),
      ),
    ];
  }
}

class _PreviewHeader extends StatelessWidget {
  const _PreviewHeader({
    required this.locale,
    required this.onLocaleChanged,
    required this.onLightMode,
    required this.onDarkMode,
    required this.onHighContrast,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final VoidCallback onLightMode;
  final VoidCallback onDarkMode;
  final VoidCallback onHighContrast;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;

    return SldsCard(
      width: double.infinity,
      height: 0,
      style: SldsCardStyle(
        padding: EdgeInsets.all(tokens.dimensions.space20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SLDS Alpha Flutter Preview',
            style: tokens.typography.desktopTitle1.copyWith(
              color: tokens.colors.textPrimary,
            ),
          ),
          SizedBox(height: tokens.dimensions.space8),
          Text(
            'Interactive coverage for all Tier 1 and Tier 2 Flutter components, using SLDS tokens and locale-aware sample content.',
            style: tokens.typography.body1.copyWith(
              color: tokens.colors.textSecondary,
            ),
          ),
          SizedBox(height: tokens.dimensions.space16),
          Wrap(
            spacing: tokens.dimensions.space8,
            runSpacing: tokens.dimensions.space8,
            children: [
              _localeButton(
                const Locale('en'),
                'English',
                locale,
                onLocaleChanged,
              ),
              _localeButton(
                const Locale('si'),
                'සිංහල',
                locale,
                onLocaleChanged,
              ),
              _localeButton(
                const Locale('ta'),
                'தமிழ்',
                locale,
                onLocaleChanged,
              ),
              SldsButton(
                size: SldsButtonSize.small,
                variant: SldsButtonVariant.secondary,
                leading: const Icon(Icons.light_mode_outlined),
                onPressed: onLightMode,
                child: const Text('Light'),
              ),
              SldsButton(
                size: SldsButtonSize.small,
                variant: SldsButtonVariant.secondary,
                leading: const Icon(Icons.dark_mode_outlined),
                onPressed: onDarkMode,
                child: const Text('Dark'),
              ),
              SldsButton(
                size: SldsButtonSize.small,
                variant: SldsButtonVariant.secondary,
                leading: const Icon(Icons.contrast_outlined),
                onPressed: onHighContrast,
                child: const Text('High contrast'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _localeButton(
    Locale target,
    String label,
    Locale selected,
    ValueChanged<Locale> onChanged,
  ) {
    return SldsButton(
      size: SldsButtonSize.small,
      variant: selected.languageCode == target.languageCode
          ? SldsButtonVariant.primary
          : SldsButtonVariant.secondary,
      onPressed: () => onChanged(target),
      child: Text(label),
    );
  }
}

class _ComponentSection extends StatelessWidget {
  const _ComponentSection({
    required this.tier,
    required this.title,
    required this.count,
    required this.children,
  });

  final String tier;
  final String title;
  final String count;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: tokens.dimensions.space8,
          runSpacing: tokens.dimensions.space8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SldsBadge(label: tier, type: SldsBadgeType.info),
            SldsBadge(label: count, type: SldsBadgeType.neutral),
          ],
        ),
        SizedBox(height: tokens.dimensions.space8),
        Text(
          title,
          style: tokens.typography.title1.copyWith(
            color: tokens.colors.textPrimary,
          ),
        ),
        SizedBox(height: tokens.dimensions.space12),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = tokens.dimensions.space16;
            final tileWidth = constraints.maxWidth < 760
                ? constraints.maxWidth
                : (constraints.maxWidth - gap) / 2;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final child in children)
                  SizedBox(width: tileWidth, child: child),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PreviewTile extends StatelessWidget {
  const _PreviewTile({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;

    return SldsCard(
      width: double.infinity,
      height: 0,
      style: SldsCardStyle(
        padding: EdgeInsets.all(tokens.dimensions.space16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tokens.typography.title1.copyWith(
              color: tokens.colors.textPrimary,
            ),
          ),
          SizedBox(height: tokens.dimensions.space4),
          Text(
            description,
            style: tokens.typography.body2.copyWith(
              color: tokens.colors.textSecondary,
            ),
          ),
          SizedBox(height: tokens.dimensions.space16),
          child,
        ],
      ),
    );
  }
}

class _Copy {
  const _Copy({
    required this.buttonPrimary,
    required this.buttonSecondary,
    required this.buttonGhost,
    required this.buttonDestructive,
    required this.emailLabel,
    required this.emailAddress,
    required this.emailHelper,
    required this.description,
    required this.descriptionHint,
    required this.descriptionHelper,
    required this.checkbox,
    required this.radioSms,
    required this.radioEmail,
    required this.toggle,
    required this.district,
    required this.districtPlaceholder,
    required this.districtHelper,
    required this.districtColombo,
    required this.districtGalle,
    required this.districtBatticaloa,
    required this.badgeApproved,
    required this.badgeInReview,
    required this.badgeRejected,
    required this.cardTitle,
    required this.cardBody,
    required this.dialogTitle,
    required this.dialogBody,
    required this.dialogPrimary,
    required this.dialogSecondary,
    required this.snackbarTitle,
    required this.snackbarBody,
    required this.snackbarAction,
    required this.tabOverview,
    required this.tabHistory,
    required this.tabFiles,
    required this.accordionTitle,
    required this.accordionBody,
    required this.listTitle,
    required this.listBody,
    required this.progressLabel,
    required this.stepperLabel,
    required this.avatarInitials,
    required this.avatarLabel,
    required this.chip,
    required this.chipRemove,
    required this.tag,
    required this.tooltipTitle,
    required this.tooltipBody,
    required this.tooltipDetail,
    required this.tooltipAction,
    required this.drawerTitle,
    required this.drawerHome,
    required this.drawerHomeBody,
    required this.drawerApplications,
    required this.drawerApplicationsBody,
  });

  final String buttonPrimary;
  final String buttonSecondary;
  final String buttonGhost;
  final String buttonDestructive;
  final String emailLabel;
  final String emailAddress;
  final String emailHelper;
  final String description;
  final String descriptionHint;
  final String descriptionHelper;
  final String checkbox;
  final String radioSms;
  final String radioEmail;
  final String toggle;
  final String district;
  final String districtPlaceholder;
  final String districtHelper;
  final String districtColombo;
  final String districtGalle;
  final String districtBatticaloa;
  final String badgeApproved;
  final String badgeInReview;
  final String badgeRejected;
  final String cardTitle;
  final String cardBody;
  final String dialogTitle;
  final String dialogBody;
  final String dialogPrimary;
  final String dialogSecondary;
  final String snackbarTitle;
  final String snackbarBody;
  final String snackbarAction;
  final String tabOverview;
  final String tabHistory;
  final String tabFiles;
  final String accordionTitle;
  final String accordionBody;
  final String listTitle;
  final String listBody;
  final String progressLabel;
  final String stepperLabel;
  final String avatarInitials;
  final String avatarLabel;
  final String chip;
  final String chipRemove;
  final String tag;
  final String tooltipTitle;
  final String tooltipBody;
  final String tooltipDetail;
  final String tooltipAction;
  final String drawerTitle;
  final String drawerHome;
  final String drawerHomeBody;
  final String drawerApplications;
  final String drawerApplicationsBody;

  static _Copy forLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'si':
        return const _Copy(
          buttonPrimary: 'ඉල්ලීම යවන්න',
          buttonSecondary: 'අවලංගු කරන්න',
          buttonGhost: 'විස්තර බලන්න',
          buttonDestructive: 'කෙටුම්පත මකන්න',
          emailLabel: 'විද්‍යුත් තැපෑල',
          emailAddress: 'citizen@example.gov.lk',
          emailHelper: 'ඊමේල් ලිපිනය ඉංග්‍රීසි අකුරු වලින් තබා ගන්න.',
          description: 'ඉල්ලීමේ විස්තර',
          descriptionHint: 'ඔබගේ ඉල්ලීමේ විස්තර ලියන්න',
          descriptionHelper: 'තිබේ නම් සේවා යොමු අංකය ඇතුළත් කරන්න.',
          checkbox: 'තොරතුරු නිවැරදි බව මම තහවුරු කරමි',
          radioSms: 'SMS යාවත්කාලීන',
          radioEmail: 'ඊමේල් යාවත්කාලීන',
          toggle: 'තත්ත්ව ඇඟවීම් සක්‍රීය කරන්න',
          district: 'දිස්ත්‍රික්කය',
          districtPlaceholder: 'දිස්ත්‍රික්කය තෝරන්න',
          districtHelper: 'මෙම සේවා ඉල්ලීමට අදාළ දිස්ත්‍රික්කය තෝරන්න.',
          districtColombo: 'කොළඹ',
          districtGalle: 'ගාල්ල',
          districtBatticaloa: 'මඩකලපුව',
          badgeApproved: 'අනුමතයි',
          badgeInReview: 'සමාලෝචනයේ',
          badgeRejected: 'ප්‍රතික්ෂේපයි',
          cardTitle: 'ආදායම් බලපත්‍ර සේවාව',
          cardBody: 'ඔබගේ වාහනය සඳහා බලපත්‍රය මාර්ගගතව අලුත් කරන්න.',
          dialogTitle: 'ඉල්ලීම තහවුරු කරන්න',
          dialogBody: 'ඉදිරියට යාමට පෙර තොරතුරු නිවැරදිද බලන්න.',
          dialogPrimary: 'යවන්න',
          dialogSecondary: 'නැවත බලන්න',
          snackbarTitle: 'සුරැකිණි',
          snackbarBody: 'ඔබගේ ප්‍රගතිය සුරක්ෂිතව සුරැකිණි.',
          snackbarAction: 'බලන්න',
          tabOverview: 'සාරාංශය',
          tabHistory: 'ඉතිහාසය',
          tabFiles: 'ගොනු',
          accordionTitle: 'අවශ්‍ය ලේඛන',
          accordionBody: 'හැඳුනුම්පත, වාහන අංකය සහ රක්ෂණ තොරතුරු අවශ්‍ය වේ.',
          listTitle: 'ආදායම් බලපත්‍රය',
          listBody: 'මාර්ගගත අලුත් කිරීමේ සේවාව',
          progressLabel: 'අයදුම්පත් ප්‍රගතිය',
          stepperLabel: 'පියවර 6න් 3',
          avatarInitials: 'නි',
          avatarLabel: 'නිමල් පෙරේරා',
          chip: 'කොළඹ',
          chipRemove: 'කොළඹ පෙරහන ඉවත් කරන්න',
          tag: 'ප්‍රමුඛ',
          tooltipTitle: 'හැඳුනුම්පත් අංකය',
          tooltipBody: 'අකුරු 10 හෝ 12 හැඳුනුම්පත් අංකය ඇතුළත් කරන්න.',
          tooltipDetail: 'අනිවාර්ය ක්ෂේත්‍රය',
          tooltipAction: 'තව දැනගන්න',
          drawerTitle: 'සේවා මෙනුව',
          drawerHome: 'මුල් පිටුව',
          drawerHomeBody: 'ඩෑෂ්බෝඩ් සාරාංශය',
          drawerApplications: 'අයදුම්පත්',
          drawerApplicationsBody: 'යවන ලද ඉල්ලීම් නිරීක්ෂණය කරන්න',
        );
      case 'ta':
        return const _Copy(
          buttonPrimary: 'கோரிக்கையை அனுப்பு',
          buttonSecondary: 'ரத்து செய்',
          buttonGhost: 'விவரங்களை பார்க்க',
          buttonDestructive: 'வரைவை நீக்கு',
          emailLabel: 'மின்னஞ்சல்',
          emailAddress: 'citizen@example.gov.lk',
          emailHelper: 'மின்னஞ்சல் முகவரியை ஆங்கில எழுத்தில் வைத்திருக்கவும்.',
          description: 'கோரிக்கை விவரங்கள்',
          descriptionHint: 'உங்கள் கோரிக்கையை விவரிக்கவும்',
          descriptionHelper: 'இருந்தால் சேவை குறிப்பு எண்ணை சேர்க்கவும்.',
          checkbox: 'தகவல் சரியானது என்பதை உறுதிப்படுத்துகிறேன்',
          radioSms: 'SMS புதுப்பிப்புகள்',
          radioEmail: 'மின்னஞ்சல் புதுப்பிப்புகள்',
          toggle: 'நிலை அறிவிப்புகளை இயக்கு',
          district: 'மாவட்டம்',
          districtPlaceholder: 'மாவட்டத்தைத் தேர்ந்தெடுக்கவும்',
          districtHelper:
              'இந்த சேவை கோரிக்கைக்கு மாவட்டத்தைத் தேர்ந்தெடுக்கவும்.',
          districtColombo: 'கொழும்பு',
          districtGalle: 'காலி',
          districtBatticaloa: 'மட்டக்களப்பு',
          badgeApproved: 'அங்கீகரிக்கப்பட்டது',
          badgeInReview: 'மதிப்பாய்வில்',
          badgeRejected: 'நிராகரிக்கப்பட்டது',
          cardTitle: 'வரி உரிம சேவை',
          cardBody: 'உங்கள் வாகன உரிமத்தை இணையத்தில் புதுப்பிக்கவும்.',
          dialogTitle: 'சமர்ப்பிப்பை உறுதிப்படுத்து',
          dialogBody:
              'தொடர்வதற்கு முன் தகவல் சரியானதா என்பதைச் சரிபார்க்கவும்.',
          dialogPrimary: 'சமர்ப்பி',
          dialogSecondary: 'சரிபார்',
          snackbarTitle: 'சேமிக்கப்பட்டது',
          snackbarBody: 'உங்கள் முன்னேற்றம் பாதுகாப்பாக சேமிக்கப்பட்டது.',
          snackbarAction: 'பார்',
          tabOverview: 'கண்ணோட்டம்',
          tabHistory: 'வரலாறு',
          tabFiles: 'கோப்புகள்',
          accordionTitle: 'தேவையான ஆவணங்கள்',
          accordionBody:
              'அடையாள அட்டை, வாகன எண் மற்றும் காப்பீட்டு விவரங்கள் தேவை.',
          listTitle: 'வரி உரிமம்',
          listBody: 'இணைய புதுப்பிப்பு சேவை',
          progressLabel: 'விண்ணப்ப முன்னேற்றம்',
          stepperLabel: '6 இல் 3 ஆம் படி',
          avatarInitials: 'நி',
          avatarLabel: 'நிமல் பெரேரா',
          chip: 'கொழும்பு',
          chipRemove: 'கொழும்பு வடிகட்டியை அகற்று',
          tag: 'முன்னுரிமை',
          tooltipTitle: 'அடையாள அட்டை எண்',
          tooltipBody: '10 அல்லது 12 எழுத்து அடையாள எண்ணை உள்ளிடவும்.',
          tooltipDetail: 'கட்டாய புலம்',
          tooltipAction: 'மேலும் அறிக',
          drawerTitle: 'சேவை பட்டி',
          drawerHome: 'முகப்பு',
          drawerHomeBody: 'டாஷ்போர்டு கண்ணோட்டம்',
          drawerApplications: 'விண்ணப்பங்கள்',
          drawerApplicationsBody: 'சமர்ப்பித்த கோரிக்கைகளைப் பின்தொடரவும்',
        );
      default:
        return const _Copy(
          buttonPrimary: 'Submit application',
          buttonSecondary: 'Cancel',
          buttonGhost: 'View details',
          buttonDestructive: 'Delete draft',
          emailLabel: 'Email address',
          emailAddress: 'citizen@example.gov.lk',
          emailHelper: 'Keep the email address in Latin characters.',
          description: 'Request details',
          descriptionHint: 'Describe your request',
          descriptionHelper: 'Include the service reference if available.',
          checkbox: 'I confirm the information is accurate',
          radioSms: 'SMS updates',
          radioEmail: 'Email updates',
          toggle: 'Enable status alerts',
          district: 'District',
          districtPlaceholder: 'Select district',
          districtHelper: 'Choose the district for this service request.',
          districtColombo: 'Colombo',
          districtGalle: 'Galle',
          districtBatticaloa: 'Batticaloa',
          badgeApproved: 'Approved',
          badgeInReview: 'In review',
          badgeRejected: 'Rejected',
          cardTitle: 'Revenue licence service',
          cardBody: 'Renew the licence for your vehicle online.',
          dialogTitle: 'Confirm submission',
          dialogBody: 'Please confirm that the details are correct.',
          dialogPrimary: 'Submit',
          dialogSecondary: 'Review',
          snackbarTitle: 'Saved',
          snackbarBody: 'Your draft has been saved.',
          snackbarAction: 'View',
          tabOverview: 'Overview',
          tabHistory: 'History',
          tabFiles: 'Files',
          accordionTitle: 'Required documents',
          accordionBody:
              'NIC copy, vehicle number, and insurance details are needed.',
          listTitle: 'Revenue licence',
          listBody: 'Online renewal service',
          progressLabel: 'Application progress',
          stepperLabel: 'Step 3 of 6',
          avatarInitials: 'NP',
          avatarLabel: 'Nimal Perera',
          chip: 'Colombo',
          chipRemove: 'Remove Colombo filter',
          tag: 'Priority',
          tooltipTitle: 'NIC number',
          tooltipBody: 'Enter the 10 or 12 character NIC number.',
          tooltipDetail: 'Required field',
          tooltipAction: 'Learn more',
          drawerTitle: 'Service menu',
          drawerHome: 'Home',
          drawerHomeBody: 'Dashboard overview',
          drawerApplications: 'Applications',
          drawerApplicationsBody: 'Track submitted requests',
        );
    }
  }
}
