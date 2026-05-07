using Godot;
using Godot.NativeInterop;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.CompilerServices;

public partial class TileBulletHelper : Node
{
	public Vector2[] GeneratePolygonHelper(float angle, float length, float radius, int stepCount, float rotation, Node2D tileBullet, Node2D ring)
	{
		List<Vector2> points = [];

		float step = (float)(angle / stepCount);
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

        for (int j = 0; j < points.Count; j++)
        {
            points[j] -= tileBullet.ToLocal(ring.ToGlobal(Vector2.FromAngle((float)(rotation - Math.PI / 2)) * radius));
        }

        return points.ToArray();
    }
}
