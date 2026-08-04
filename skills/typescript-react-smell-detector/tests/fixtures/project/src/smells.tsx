// biome-ignore-all lint: This fixture intentionally contains scanner candidates.
// @ts-ignore
'use client';

const value: any = input;
const unsafe = input as unknown as User;
const name = user!.name;
function select<T extends string>(item: T) {
  return item;
}
type Combined = Named & { active: boolean };
const labels: Record<string, string> = { ready: 'Ready' };
// biome-ignore format: Keep same-line React Hook Form evidence for the regex fixture.
const controlled = <Controller render={({ field }) => <input {...field} {...register("name")} />} />;
const registeredControlled = <input {...register('email')} value={email} />;
const watched = watch('name');
const rows = items.map((item, index) => <Row key={index} item={item} />);
const generatedKey = <Row key={useId()} />;
const mutation = useMutation({ mutationFn: saveAction, throwOnError: true });
const state = useState(0);
const propState = useState(props.value);
const callback = useCallback(() => state, [state]);
const memoized = useMemo(() => state * 2, [state]);
useEffect(() => setReady(true), []);
