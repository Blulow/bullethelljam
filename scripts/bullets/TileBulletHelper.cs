using Godot;
using Godot.NativeInterop;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

public partial class TileBulletHelper : Node
{
	public Vector2[] GeneratePolygonHelper(float angle, float length, float radius, float rotation, Node2D tileBullet, Node2D ring)
	{
		List<Vector2> points = [];

		float step = (float)(angle / 20);
		float i = (float)(-angle / 2 + step);
		while (i <= angle / 2 + step)
		{
            points.Add(tileBullet.ToLocal(ring.ToGlobal(Vector2.FromAngle((float)(i + rotation - Math.PI / 2)) * radius)));
			i += step;
		}
		i = angle / 2;
        while (i >= -angle / 2)
        {
            points.Add(tileBullet.ToLocal(ring.ToGlobal(Vector2.FromAngle((float)(i + rotation - Math.PI / 2)) * (radius - length))));
            i -= step;
        }
		return points.ToArray();
    }
}
