import 'package:equatable/equatable.dart';

import './../../model/_model.dart';

abstract class BlocEventAddress extends Equatable {
  final _props;

  BlocEventAddress({props}) : this._props = (props != null) ? props : [];

  @override
  List<Object> get props => _props;
}

class BlocEventAddressFetch extends BlocEventAddress {}

abstract class BlocEventAddressCUD extends BlocEventAddress {
  BlocEventAddressCUD({props}) : super(props: props);
}

class BlocEventAddressCUDCreate extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressCUDCreate(this.address) : super(props: [address]);
}

class BlocEventAddressCUDUpdate extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressCUDUpdate(this.address) : super(props: [address]);
}

class BlocEventAddressCUDDelete extends BlocEventAddressCUD {
  final Address address;

  BlocEventAddressCUDDelete(this.address) : super(props: [address]);
}

class BlocEventAddressCUDDeleteAll extends BlocEventAddressCUD {}
