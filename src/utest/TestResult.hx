package utest;

import utest.Assertation;

class TestResult {
  public var instanceName  : String;
  public var pack          : String;
  public var cls           : String;
  public var method        : String;
  public var setup         : String;
  public var teardown      : String;
  public var assertations  : List<Assertation>;

  public function new(){}

  public static function ofHandler(handler : TestHandler<Dynamic>) {
    var r = new TestResult();
    var target = handler.fixture.target;
    var path = Type.getClassName(Type.getClass(target)).split('.');
    var instanceName = try{ Reflect.getProperty( target , "name" ); } catch(e:Dynamic) { null; };

    r.cls           = path.pop();
    r.pack          = path.join('.');
    r.method        = handler.fixture.method;
    r.instanceName  = instanceName;
    r.setup         = handler.fixture.setup;
    r.teardown      = handler.fixture.teardown;
    r.assertations  = handler.results;
    return r;
  }

  public function allOk():Bool{
    for(l in assertations) {
      switch (l){
        case Success(_): break;
        default: return false;
      }
    }
    return true;
  }
}
