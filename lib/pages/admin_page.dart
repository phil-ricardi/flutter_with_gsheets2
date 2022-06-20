import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../utils/inkwell_overlay.dart';
import '../utils/open_container_wrapper.dart';

const double _fabDimension = 56;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showSettingsBottomModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 125,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Text for something else, 567856785678',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(2),
                    selectedBorderColor: Theme.of(context).colorScheme.primary,
                    onPressed: (index) {
                      setModalState(() {
                        setState(() {
                          _transitionType = index == 0
                              ? ContainerTransitionType.fade
                              : ContainerTransitionType.fadeThrough;
                        });
                      });
                    },
                    isSelected: <bool>[
                      _transitionType == ContainerTransitionType.fade,
                      _transitionType == ContainerTransitionType.fadeThrough,
                    ],
                    children: const [
                      Text(
                        'Fade',
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          'Fade Through',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ValueKey(_transitionType),
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (context) => Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Column(
                children: const [
                  Text(
                    'App Bar Text 1111',
                  ),
                  Text(
                    'App Bar Text 222222',
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    _showSettingsBottomModalSheet(context);
                  },
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (context, openContainer) {
                    return _DetailsCard(openContainer: openContainer);
                  },
                ),
                const SizedBox(height: 16),
                OpenContainerWrapper(
                  transitionType: _transitionType,
                  closedBuilder: (context, openContainer) {
                    return _DetailsListTile(openContainer: openContainer);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: 'SubTitle 66666666',
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: 'SubTitle 77777777',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: 'SubTitle 88888',
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: 'SubTitle 99999999',
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OpenContainerWrapper(
                        transitionType: _transitionType,
                        closedBuilder: (context, openContainer) {
                          return _SmallDetailsCard(
                            openContainer: openContainer,
                            subtitle: 'SubTitle 00000000000',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...List.generate(10, (index1) {
                  return OpenContainer<bool>(
                    transitionType: _transitionType,
                    openBuilder: (context, openContainer) =>
                        const DetailsPage(),
                    tappable: false,
                    closedShape: const RoundedRectangleBorder(),
                    closedElevation: 1,
                    closedBuilder: (context, openContainer) {
                      return ListTile(
                        leading: const Icon(Icons.access_alarm),
                        tileColor: Colors.deepPurple,
                        onTap: openContainer,
                        title: Text(
                          'List Tile text for Title ${index1 + 1}',
                          style: const TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'SubTitle 1111122222222',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
            floatingActionButton: OpenContainer(
              transitionType: _transitionType,
              openBuilder: (context, openContainer) => const DetailsPage(),
              closedElevation: 6,
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(_fabDimension / 2),
                ),
              ),
              closedBuilder: (context, openContainer) {
                return const SizedBox(
                  height: _fabDimension,
                  width: _fabDimension,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.lightBlue,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return InkWellOverlay(
      openContainer: openContainer,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black38,
              child: const Center(
                child: Text('Text for this shit 4444444444444'),
              ),
            ),
          ),
          const ListTile(
            title: Text(
              'List Tile text for _DetailsCard',
              style: TextStyle(
                  color: Colors.lime,
                  inherit: false,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'SubTitle _DetailsCard',
              style: TextStyle(
                  color: Colors.deepOrange,
                  inherit: false,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur '
              'adipiscing elit, sed do eiusmod tempor.',
              style: TextStyle(
                  color: Colors.black54,
                  inherit: false,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallDetailsCard extends StatelessWidget {
  const _SmallDetailsCard({
    required this.openContainer,
    required this.subtitle,
  });

  final VoidCallback openContainer;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWellOverlay(
      openContainer: openContainer,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black38,
            height: 125,
            child: const Center(
              child: Text(
                'Text in SmallDetailsCard',
                style: TextStyle(color: Colors.brown),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Text in a SmallDetailsCard',
                  style: TextStyle(color: Colors.purple),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsListTile extends StatelessWidget {
  const _DetailsListTile({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    const height = 120.0;

    return InkWellOverlay(
      openContainer: openContainer,
      height: height,
      child: Row(
        children: [
          Container(
            color: Colors.black38,
            height: height,
            width: height,
            child: const Center(
              child: Text(
                'Center DetailsListTile',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Subtitle DetailsListTile',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur '
                    'adipiscing elit,',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  //! page for when clicking in tile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is shittttty'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black38,
            height: 250,
            child: const Padding(
              padding: EdgeInsets.all(70),
              child: Text(
                'CONTAINER TEXT FOR FIGURING THIS OUT',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CONTAINER TEXT FOR FIGURING THIS OUT',
                ),
                SizedBox(height: 10),
                Text(
                  'bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ',
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
