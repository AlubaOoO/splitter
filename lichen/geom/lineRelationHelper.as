package §-_-___---__§
{
   import §-__---_-_--_-§.my_edge_collide_class;
   import §-___--____-_--§.my_error_logger;
   import com.qunhe.commons.math.geom.my_Rect;
   import com.qunhe.commons.math.geom.my2D_Edge;
   import com.qunhe.commons.math.geom.Interval;
   import com.qunhe.commons.math.geom.Vec2;
   import com.qunhe.commons.math.types.Line2DIntersectionStatus;
   import org.as3commons.logging.api.ILogger;
   import org.as3commons.logging.api.getLogger;
   
   public final class lineRelationHelper
   {
      
      private static const LOG:ILogger = getLogger(lineRelationHelper);
      
      private static const DISTANCE_TOLERANCE:Number = 0.01;
      
      private static const const_local_epsilon:Number = 0.01;
       
      
      public function lineRelationHelper()
      {
         super();
         throw new my_error_logger();
      }
      
      public static function create_edge_collider(param1:my2D_Edge, param2:my2D_Edge, param3:Number = 0.01) : my_edge_collide_class
      {
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Vec2 = null;
         var _loc25_:Vec2 = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc4_:Vec2 = param1.start;
         var _loc5_:Vec2 = param2.start;
         var _loc6_:Vec2 = param1.end;
         var _loc7_:Vec2 = param2.end;
         var _loc8_:Vec2 = Vec2.sub(_loc6_,_loc4_);
         var _loc9_:Vec2 = Vec2.sub(_loc7_,_loc5_);
         var _loc10_:Number = Vec2.cross(_loc8_,_loc9_);
         var _loc11_:Number = Vec2.cross(Vec2.sub(_loc5_,_loc4_),_loc8_);
         var _loc12_:Number = Vec2.cross(Vec2.sub(_loc5_,_loc4_),_loc9_);
         var _loc13_:my_edge_collide_class = new my_edge_collide_class();
         if(my_number.isZeroOrOrigin(_loc10_,param3))
         {
            if(my_number.isZeroOrOrigin(_loc12_,param3) && my_number.isZeroOrOrigin(_loc11_,param3))
            {
               _loc14_ = Vec2.dot(Vec2.sub(_loc5_,_loc4_),_loc8_);
               _loc15_ = Vec2.dot(Vec2.sub(_loc7_,_loc4_),_loc8_);
               _loc16_ = Vec2.dot(Vec2.sub(_loc4_,_loc5_),_loc9_);
               _loc17_ = Vec2.dot(Vec2.sub(_loc6_,_loc5_),_loc9_);
               _loc18_ = Vec2.dot(_loc8_,_loc8_);
               _loc19_ = Vec2.dot(_loc9_,_loc9_);
               _loc20_ = _loc14_ / _loc18_;
               _loc21_ = _loc15_ / _loc18_;
               _loc22_ = _loc16_ / _loc19_;
               _loc23_ = _loc17_ / _loc19_;
               _loc24_ = new Vec2(0,0);
               _loc24_.x = Math.min(_loc20_,_loc21_);
               _loc24_.y = Math.max(_loc20_,_loc21_);
               _loc25_ = new Vec2(0,0);
               _loc25_.x = Math.min(_loc22_,_loc23_);
               _loc25_.y = Math.max(_loc22_,_loc23_);
               _loc13_.ratio1 = _loc24_;
               _loc13_.ratio2 = _loc25_;
               if(_loc14_ >= 0 && _loc14_ <= _loc18_ || _loc15_ >= 0 && _loc15_ <= _loc18_ || _loc16_ >= 0 && _loc16_ <= _loc19_ || _loc17_ >= 0 && _loc17_ <= _loc19_)
               {
                  _loc24_.x = my_math.clamp_0_1(_loc24_.x);
                  _loc24_.y = my_math.clamp_0_1(_loc24_.y);
                  _loc25_.x = my_math.clamp_0_1(_loc25_.x);
                  _loc25_.y = my_math.clamp_0_1(_loc25_.y);
                  _loc13_.status = Line2DIntersectionStatus.OVERLAPPING;
               }
               else
               {
                  _loc13_.status = Line2DIntersectionStatus.COLLINEAR;
               }
            }
            else
            {
               _loc13_.status = Line2DIntersectionStatus.PARALLEL;
            }
         }
         else
         {
            _loc26_ = my_number.getYourSelf(_loc12_ / _loc10_);
            _loc27_ = my_number.getYourSelf(_loc11_ / _loc10_);
            _loc13_.ratio1 = new Vec2(_loc26_,_loc26_);
            _loc13_.ratio2 = new Vec2(_loc27_,_loc27_);
            _loc13_.point = param1.interpolate(_loc26_);
            if(_loc26_ >= 0 && _loc26_ <= 1 && _loc27_ >= 0 && _loc27_ <= 1)
            {
               _loc13_.status = Line2DIntersectionStatus.SEGMENTS_INTERSECT;
            }
            else if(_loc27_ >= 0 && _loc27_ <= 1)
            {
               _loc13_.status = Line2DIntersectionStatus.A_BISECTS_B;
            }
            else if(_loc26_ >= 0 && _loc26_ <= 1)
            {
               _loc13_.status = Line2DIntersectionStatus.B_BISECTS_A;
            }
            else
            {
               _loc13_.status = Line2DIntersectionStatus.LINES_INTERSECT;
            }
         }
         return _loc13_;
      }
      
      public static function §-___---__--__§(param1:my2D_Edge, param2:my2D_Edge, param3:Number = 0.01) : Vec2
      {
         var _loc4_:my_edge_collide_class = lineRelationHelper.create_edge_collider(param1,param2,param3);
         if(_loc4_.status == Line2DIntersectionStatus.SEGMENTS_INTERSECT)
         {
            return _loc4_.point;
         }
         return null;
      }
      
      public static function getEdgeInterSectionPoint(param1:my2D_Edge, param2:my2D_Edge, param3:Boolean = false, param4:Number = 0.01) : Vec2
      {
         var _loc5_:Vec2 = my2D_Edge.getIntersection(param2,param1);
         if(_loc5_ == null)
         {
            return null;
         }
         if(param3)
         {
            if(param1.distanceSmallThan(_loc5_,param4))
            {
               return _loc5_;
            }
         }
         else if(param1.pointInEdgeOrOnEdge(_loc5_,param4))
         {
            return _loc5_;
         }
         return null;
      }
      
      public static function §--__-----_-_-§(param1:my2D_Edge, param2:my2D_Edge, param3:Boolean = false, param4:Number = 0.01) : Boolean
      {
         var _loc5_:my_edge_collide_class = create_edge_collider(param1,param2,param4);
         if(_loc5_.status == Line2DIntersectionStatus.SEGMENTS_INTERSECT)
         {
            return param3 || !(my_number.my_number_isZero(_loc5_.ratio1.x) || my_number.my_number_isZero(_loc5_.ratio2.x));
         }
         return false;
      }
      
      public static function §--_-__-_---__§(param1:my2D_Edge, param2:my2D_Edge, param3:Boolean = false, param4:Number = 0.01) : Boolean
      {
         var _loc5_:my_edge_collide_class = create_edge_collider(param1,param2,param4);
         if(_loc5_.status == Line2DIntersectionStatus.OVERLAPPING)
         {
            return param3 || !my_number.isEqual(_loc5_.ratio1.x,_loc5_.ratio1.y,const_local_epsilon) || !my_number.my_number_isZero(_loc5_.ratio1.x,const_local_epsilon);
         }
         return false;
      }
      
      public static function isIntersectedInHelper(param1:my2D_Edge, param2:my2D_Edge, param3:Boolean = false, param4:Number = 0.01) : Boolean
      {
         var _loc5_:my_edge_collide_class = create_edge_collider(param1,param2,param4);
         switch(_loc5_.status)
         {
            case Line2DIntersectionStatus.SEGMENTS_INTERSECT:
               return param3 || !(my_number.my_number_isZero(_loc5_.ratio1.x) || my_number.my_number_isZero(_loc5_.ratio2.x));
            case Line2DIntersectionStatus.OVERLAPPING:
               return param3 || !my_number.isEqual(_loc5_.ratio1.x,_loc5_.ratio1.y) || !my_number.my_number_isZero(_loc5_.ratio1.x);
            default:
               return false;
         }
      }
      
      public static function §-__-__--__-_--§(param1:my2D_Edge, param2:Vector.<my2D_Edge>) : Vector.<Interval>
      {
         var line:my2D_Edge = null;
         var alpha:Number = NaN;
         var inter:my_edge_collide_class = null;
         var result:my_edge_collide_class = null;
         var subject:my2D_Edge = param1;
         var clips:Vector.<my2D_Edge> = param2;
         var boundingBox:my_Rect = subject.getBoundingBox();
         var intervals:Vector.<Interval> = new Vector.<Interval>();
         var intersets:Vector.<my_edge_collide_class> = new Vector.<my_edge_collide_class>();
         for each(line in clips)
         {
            if(boundingBox.isIntersected(line.getBoundingBox()))
            {
               result = lineRelationHelper.create_edge_collider(subject,line);
               if(result.status == Line2DIntersectionStatus.OVERLAPPING || result.status == Line2DIntersectionStatus.SEGMENTS_INTERSECT)
               {
                  intersets.push(result);
               }
            }
         }
         intersets.sort(function(param1:my_edge_collide_class, param2:my_edge_collide_class):Number
         {
            return my_math.sign(param1.ratio1.x - param2.ratio1.x);
         });
         alpha = 0;
         for each(inter in intersets)
         {
            if(inter.status == Line2DIntersectionStatus.SEGMENTS_INTERSECT)
            {
               if(my_number.§-____-----_§(inter.ratio1.x,alpha))
               {
                  intervals.push(new Interval(alpha,inter.ratio1.x));
                  alpha = inter.ratio1.x;
               }
            }
            else if(inter.status == Line2DIntersectionStatus.OVERLAPPING)
            {
               if(my_number.§-____-----_§(inter.ratio1.x,alpha))
               {
                  intervals.push(new Interval(alpha,inter.ratio1.x));
               }
               if(my_number.§-____-----_§(inter.ratio1.y,alpha))
               {
                  alpha = inter.ratio1.y;
               }
            }
         }
         if(my_number.§-__-_----_-§(alpha,1))
         {
            intervals.push(new Interval(alpha,1));
         }
         return intervals;
      }
      
      public static function §---_----___-_§(param1:my2D_Edge, param2:Vector.<my2D_Edge>) : Vector.<my2D_Edge>
      {
         var _loc5_:Interval = null;
         var _loc3_:Vector.<Interval> = §-__-__--__-_--§(param1,param2);
         var _loc4_:Vector.<my2D_Edge> = new Vector.<my2D_Edge>();
         for each(_loc5_ in _loc3_)
         {
            _loc4_.push(param1.getExpanded(_loc5_.min,_loc5_.max));
         }
         return _loc4_;
      }
      
      public static function §-___-_-_-___-§(param1:Vec2, param2:Vector.<my2D_Edge>) : my2D_Edge
      {
         var _loc4_:Number = NaN;
         var _loc5_:my2D_Edge = null;
         var _loc6_:my2D_Edge = null;
         var _loc3_:Number = Number.MAX_VALUE;
         for each(_loc6_ in param2)
         {
            _loc4_ = _loc6_.getDistance(param1,true);
            if(_loc4_ < _loc3_)
            {
               _loc3_ = _loc4_;
               _loc5_ = _loc6_;
            }
         }
         return _loc5_;
      }
      
      public static function §-__-______----§(param1:Vec2, param2:Vec2, param3:Number) : Vector.<Vec2>
      {
         var _loc4_:Vec2 = Vec2.sub(param2,param1).rotate_minus_90_degree().normalize();
         var _loc5_:Number = 0.5 * param3;
         var _loc6_:Vec2 = _loc4_.mul(_loc5_);
         var _loc7_:Vec2 = _loc4_.mul(-_loc5_);
         var _loc8_:Vector.<Vec2> = new Vector.<Vec2>(4);
         _loc8_[0] = Vec2.add(param1,_loc6_);
         _loc8_[1] = Vec2.add(param1,_loc7_);
         _loc8_[2] = Vec2.add(param2,_loc7_);
         _loc8_[3] = Vec2.add(param2,_loc6_);
         return _loc8_;
      }
      
      public static function §-___-_--_--__-§(param1:Vector.<my2D_Edge>, param2:my2D_Edge, param3:Number = 20) : my2D_Edge
      {
         var _loc5_:my2D_Edge = null;
         var _loc6_:my2D_Edge = null;
         var _loc7_:Number = NaN;
         var _loc4_:Number = Number.MAX_VALUE;
         for each(_loc6_ in param1)
         {
            if(my2D_Edge.isValidAngleDiff(_loc6_,param2))
            {
               _loc7_ = param2.verticalDistanceSquare(_loc6_.start);
               if(_loc7_ < _loc4_)
               {
                  _loc4_ = _loc7_;
                  _loc5_ = _loc6_;
               }
            }
         }
         if(_loc4_ > param3 * param3)
         {
            return null;
         }
         return _loc5_;
      }
   }
}
