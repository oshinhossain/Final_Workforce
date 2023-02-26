import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class DefaultTooltipComponent extends StatefulWidget {
  final Widget child;
  final Widget content;
  final Color backgroundColor;

  DefaultTooltipComponent({
    super.key,
    required this.child,
    required this.content,
    this.backgroundColor = Colors.white,
  });

  @override
  State<DefaultTooltipComponent> createState() =>
      _DefaultTooltipComponentState();
}

class _DefaultTooltipComponentState extends State<DefaultTooltipComponent> {
  final tooltipController = JustTheController();
  var length = 10.0;
  var color = Colors.white;
  var alignment = Alignment.center;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      tooltipController.showTooltip(immediately: false);
    });

    tooltipController.addListener(() {
      // print('controller: ${tooltipController.value}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.all(16.0);
    return JustTheTooltip(
      onShow: () {
        // print('onShow');
      },
      onDismiss: () {
        // print('onDismiss');
      },
      backgroundColor: widget.backgroundColor,
      controller: tooltipController,
      tailLength: length,
      tailBaseWidth: 20.0,
      isModal: true,
      preferredDirection: AxisDirection.up,
      margin: margin,
      borderRadius: BorderRadius.circular(8.0),
      offset: 0,
      child: widget.child,
      content: widget.content,
      // child: Material(
      //   color: Colors.grey.shade800,
      //   shape: CircleBorder(),
      //   elevation: 4.0,
      //   child: Padding(
      //     padding: EdgeInsets.all(8.0),
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      // content: Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: ConstrainedBox(
      //     constraints: BoxConstraints(maxWidth: 200.0),
      //     child: Text(
      //       'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor.',
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
    );
    // return Scaffold(
    //   appBar: AppBar(),
    //   floatingActionButton: Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       ElevatedButton(
    //         child: Icon(Icons.add),
    //         onPressed: () {
    //           tooltipController.showTooltip(immediately: true);
    //         },
    //       ),
    //       SizedBox(width: 8),
    //       ElevatedButton(
    //         child: Icon(Icons.remove),
    //         onPressed: () {
    //           tooltipController.hideTooltip(immediately: true);
    //         },
    //       ),
    //     ],
    //   ),
    //   body: SizedBox.expand(
    //     child: AnimatedAlign(
    //       duration: const Duration(milliseconds: 1500),
    //       alignment: alignment,
    //       child: JustTheTooltip(
    //         onShow: () {
    //           // print('onShow');
    //         },
    //         onDismiss: () {
    //           // print('onDismiss');
    //         },
    //         backgroundColor: color,
    //         controller: tooltipController,
    //         tailLength: length,
    //         tailBaseWidth: 20.0,
    //         isModal: true,
    //         preferredDirection: AxisDirection.up,
    //         margin: margin,
    //         borderRadius: BorderRadius.circular(8.0),
    //         offset: 0,
    //         child: Material(
    //           color: Colors.grey.shade800,
    //           shape: CircleBorder(),
    //           elevation: 4.0,
    //           child: Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Icon(
    //               Icons.add,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         content: Padding(
    //           padding: EdgeInsets.all(8.0),
    //           child: ConstrainedBox(
    //             constraints: BoxConstraints(maxWidth: 200.0),
    //             child: Text(
    //               'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor.',
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class ScrollExamplePage extends StatelessWidget {
  // const ScrollExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tooltip follow example'),
      ),
      body: ListView(
        children: List.generate(30, (index) {
          if (index == 15) {
            return JustTheTooltip(
              tailLength: 10.0,
              isModal: true,
              preferredDirection: AxisDirection.down,
              child: Material(
                color: Colors.blue,
                shape: CircleBorder(),
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.touch_app,
                    color: Colors.white,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 120,
                    color: Colors.blue,
                    width: double.infinity,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Quia ducimus eius magni voluptatibus ut veniam ducimus. Ullam ab qui voluptatibus quos est in. Maiores eos ab magni tempora praesentium libero. Voluptate architecto rerum vel sapiente ducimus aut cumque quibusdam. Consequatur illo et quos vel cupiditate quis dolores at.',
                  ),
                ],
              ),
            );
          }

          return ListTile(title: Text('Item $index'));
        }),
      ),
    );
  }
}

class TooltipAreaExamplePage extends StatefulWidget {
  // const TooltipAreaExamplePage({Key? key}) : super(key: key);

  @override
  State<TooltipAreaExamplePage> createState() => _TooltipAreaExamplePageState();
}

class _TooltipAreaExamplePageState extends State<TooltipAreaExamplePage> {
  final titleController = TextEditingController(
    text: 'Lorem ipsum dolor',
  );
  final descriptionController = TextEditingController(
    text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim '
        'ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut ',
  );
  final scrollController = ScrollController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('It goes under me')),
      body: JustTheTooltipArea(
        builder: (context, tooltip, scrim) {
          return Stack(
            fit: StackFit.passthrough,
            children: [
              ListView(
                controller: scrollController,
                children: List.generate(
                  40,
                  (index) {
                    if (index == 15) {
                      return JustTheTooltipEntry(
                        scrollController: scrollController,
                        isModal: true,
                        tailLength: 20.0,
                        preferredDirection: AxisDirection.down,
                        margin: const EdgeInsets.all(16.0),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        child: const Material(
                          color: Colors.blue,
                          shape: CircleBorder(),
                          elevation: 4.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.touch_app,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                maxLines: null,
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: Theme.of(context).textTheme.headline6,
                                controller: titleController,
                              ),
                              const SizedBox(height: 12.0),
                              TextField(
                                controller: descriptionController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {},
                                      child: const Text('exercises'),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {},
                                      child: const Text('course'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    return ListTile(title: Text('Item $index'));
                  },
                ),
              ),
              scrim,
              tooltip,
            ],
          );
        },
      ),
    );
  }
}
